terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }

  # Configuración parcial: bucket, key y región vienen de backend.hcl
  # (terraform init -backend-config=backend.hcl)
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

# ── Empaquetar handler.py como ZIP ────────────────────────────────────────────
# archive_file corre localmente durante terraform plan.
# Lee app/handler.py y genera lambda.zip en la raíz del proyecto.
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/app/handler.py"
  output_path = "${path.module}/lambda.zip"
}

# ── IAM execution role ────────────────────────────────────────────────────────
# Serverless Framework crea este role automáticamente.
# Con Terraform lo declaramos nosotros en HCL.
resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ── Lambda Function ───────────────────────────────────────────────────────────
resource "aws_lambda_function" "hello" {
  function_name    = var.project_name
  role             = aws_iam_role.lambda_exec.arn
  runtime          = "python3.11"
  handler          = "handler.lambda_handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  depends_on = [aws_iam_role_policy_attachment.lambda_logs]

  tags = {
    ManagedBy = "Terraform"
  }
}

# ── API Gateway v2 ───────────────────────────────────────────────────────────
# Equivalente a "events.httpApi" en serverless.yml.
# Serverless lo crea con 2 líneas de YAML; Terraform requiere 5 recursos.

resource "aws_apigatewayv2_api" "hello" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "hello" {
  api_id                 = aws_apigatewayv2_api.hello.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.hello.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "hello" {
  api_id    = aws_apigatewayv2_api.hello.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.hello.id}"
}

resource "aws_apigatewayv2_stage" "hello" {
  api_id      = aws_apigatewayv2_api.hello.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.hello.execution_arn}/*/*"
}

output "api_url" {
  description = "URL del endpoint en API Gateway v2"
  # api_endpoint no lleva slash final; invoke_url del stage $default sí → "//hello"
  value = "${aws_apigatewayv2_api.hello.api_endpoint}/hello"
}

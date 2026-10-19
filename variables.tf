variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre de la función Lambda y prefijo de recursos IAM"
  type        = string
  default     = "tf-lambda-demo"
}

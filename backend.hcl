bucket       = "tf-state-aarontimana04-utec"         # debe ser único a nivel global
key          = "tf-lambda-demo/terraform.tfstate"
region       = "us-east-1"
use_lockfile = true                              # bloqueo nativo en S3, sin DynamoDB

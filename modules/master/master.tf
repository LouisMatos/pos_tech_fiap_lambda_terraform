data "aws_caller_identity" "account" {}

resource "aws_lambda_function" "jlapp_lambda" {
  function_name = var.function_name

  image_uri = "${data.aws_caller_identity.account.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.imagem_name}"

  package_type = var.package_type

  role = aws_iam_role.lambda_role.arn

  timeout = var.timeout

  memory_size = var.memory_size

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
      JWT_SECRET          = random_password.jwt_secret.result
    }
  }
}

# Gerado pelo Terraform - nunca mais hardcoded no codigo/CI.
resource "random_password" "jwt_secret" {
  length  = 48
  special = false
}
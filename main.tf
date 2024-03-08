provider "aws" {
  region = "us-east-1"
}

module "iam_assumable_role_create" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-create"
  version = "~> 4.0"

  create_role      = true
  role_name        = "lambda_role"
  role_description = "Role for Lambda"
  trust_policy_document = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      },
    ]
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
}


resource "aws_iam_role_policy" "lambda" {
  name   = "lambda"
  role   = module.iam_assumable_role_create.iam_role_arn
  policy = data.aws_iam_policy_document.lambda.json
}


resource "aws_lambda_function" "code_lambda_autenticacao_cliente" {
  function_name = "lambda_autenticacao_cliente"

  image_uri = "${var.ecr_repository}/pos_tech_fiap:latest"

  package_type = "Image"

  role = module.iam_assumable_role_create.iam_role_arn

  timeout = 60

  memory_size = 128
}
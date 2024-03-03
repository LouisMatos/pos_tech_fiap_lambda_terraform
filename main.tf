provider "aws" {
  region = "us-east-1"
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
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
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda.json
}


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda.zip"
  output_path = "lambda.zip"
}


resource "null_resource" "check_lambda_zip" {
  provisioner "local-exec" {
    command = "if [ ! -f lambda.zip ]; then touch lambda.zip; fi"
  }

  triggers = {
    always_run = timestamp()
  }
}


resource "aws_lambda_function" "code_lambda_autenticacao_cliente" {
  depends_on    = [null_resource.check_lambda_zip]

  filename      = "lambda.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256("lambda.zip")

  runtime = "python3.10"

  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }

  #function_name = "lambda_autenticacao_cliente"
 # role          = aws_iam_role.lambda_role.arn

  s3_bucket = "codigo-lambda"
  s3_key    = "lambda.zip"

  #runtime = "python3.10"
 #handler = "lambda_function.lambda_handler"
}

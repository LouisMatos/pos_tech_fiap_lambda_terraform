data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
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

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Scan",
      "dynamodb:Query"
    ]

    resources = [
      "arn:aws:dynamodb:${var.aws_region}:*:table/*"
    ]
  }
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "DynamoDBAccessPolicy"
  description = "Policy to allow Lambda function to access DynamoDB"
  policy      = data.aws_iam_policy_document.dynamodb_access.json
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role_${var.version_role}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda" {
  name   = "lambda"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda.json
}

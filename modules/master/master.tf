resource "aws_lambda_function" "jlapp_lambda" {
  function_name = var.function_name

  image_uri = "${var.ecr_repository}/${var.imagem_name}"

  package_type = var.package_type

  role = aws_iam_role.lambda_role.arn

  timeout = var.timeout

  memory_size = var.memory_size
}
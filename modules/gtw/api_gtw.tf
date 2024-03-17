# Create the API Gateway
resource "aws_api_gateway_rest_api" "lambda_api_gtw" {
  name        = var.name_api_gtw
  description = var.description_name_api_gtw
}


resource "aws_api_gateway_resource" "lambda_api_gtw_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  parent_id   = aws_api_gateway_rest_api.lambda_api_gtw.root_resource_id
  path_part   = var.path_lambda_pos_tech
}

# Define a GET method on the "/users" resource.
resource "aws_api_gateway_method" "lambda_get_cliente" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id   = aws_api_gateway_resource.lambda_api_gtw_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integration between the GET method and the Lambda function
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id = aws_api_gateway_resource.lambda_api_gtw_resource.id
  http_method = aws_api_gateway_method.lambda_get_cliente.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.jlapp_lambda.invoke_arn
}

# Granting API Gateway permissions to invoke the Lambda function
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.jlapp_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.lambda_api_gtw.execution_arn}/*/${aws_api_gateway_method.lambda_get_cliente.http_method}${aws_api_gateway_resource.lambda_api_gtw_resource.path}"
  depends_on = [aws_api_gateway_deployment.prod_deployment]
}


# Deployment of the API
resource "aws_api_gateway_deployment" "prod_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  stage_name  = "prod"
}


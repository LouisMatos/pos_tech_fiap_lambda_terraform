# Create the API Gateway
resource "aws_api_gateway_rest_api" "lambda_api_gtw" {
  name        = var.name_api_gtw
  description = var.description_name_api_gtw
}

// rota /cliente
resource "aws_api_gateway_resource" "lambda_api_gtw_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  parent_id   = aws_api_gateway_rest_api.lambda_api_gtw.root_resource_id
  path_part   = var.path_lambda_pos_tech
}

// rota /cliente
resource "aws_api_gateway_method" "lambda_get_cliente" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id   = aws_api_gateway_resource.lambda_api_gtw_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

// rota /cliente/{cpf}
resource "aws_api_gateway_resource" "lambda_api_gtw_resource_cpf" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  parent_id   = aws_api_gateway_resource.lambda_api_gtw_resource.id
  path_part   = var.path_lambda_pos_tech_cpf
}

// rota /cliente/{cpf}
resource "aws_api_gateway_method" "lambda_get_cliente_cpf" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id   = aws_api_gateway_resource.lambda_api_gtw_resource_cpf.id
  http_method   = "GET"
  authorization = "NONE"
}

// rota /jwt
resource "aws_api_gateway_resource" "lambda_api_gtw_resource_jws" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  parent_id   = aws_api_gateway_rest_api.lambda_api_gtw.root_resource_id
  path_part   = var.path_lambda_pos_tech_jwt
}

// rota /jwt
resource "aws_api_gateway_method" "lambda_post_jws" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id   = aws_api_gateway_resource.lambda_api_gtw_resource_jws.id
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

// rota /jwt
resource "aws_api_gateway_integration" "lambda_jwt" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id = aws_api_gateway_resource.lambda_api_gtw_resource_jws.id
  http_method = aws_api_gateway_method.lambda_post_jws.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.jlapp_lambda.invoke_arn
}

// rota /client/{cpf}
resource "aws_api_gateway_integration" "lambda_cpf" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  resource_id = aws_api_gateway_resource.lambda_api_gtw_resource_cpf.id
  http_method = aws_api_gateway_method.lambda_get_cliente_cpf.http_method

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

  source_arn ="${aws_api_gateway_rest_api.lambda_api_gtw.execution_arn}/*/${aws_api_gateway_method.lambda_get_cliente.http_method}${aws_api_gateway_resource.lambda_api_gtw_resource.path}"
  depends_on = [aws_api_gateway_deployment.prod_deployment]
}

# Granting API Gateway permissions to invoke the Lambda function
resource "aws_lambda_permission" "apigw_jwt" {
  statement_id  = "AllowAPIGatewayInvoke2"
  action        = "lambda:InvokeFunction"
  function_name = var.jlapp_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn ="${aws_api_gateway_rest_api.lambda_api_gtw.execution_arn}/*/${aws_api_gateway_method.lambda_post_jws.http_method}${aws_api_gateway_resource.lambda_api_gtw_resource_jws.path}"
  depends_on = [aws_api_gateway_deployment.prod_deployment]
}

# Granting API Gateway permissions to invoke the Lambda function
resource "aws_lambda_permission" "apigw_cpf" {
  statement_id  = "AllowAPIGatewayInvoke3"
  action        = "lambda:InvokeFunction"
  function_name = var.jlapp_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn ="${aws_api_gateway_rest_api.lambda_api_gtw.execution_arn}/*/${aws_api_gateway_method.lambda_get_cliente_cpf.http_method}${aws_api_gateway_resource.lambda_api_gtw_resource_cpf.path}"
  depends_on = [aws_api_gateway_deployment.prod_deployment]
}



# Deployment of the API
resource "aws_api_gateway_deployment" "prod_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gtw.id
  stage_name  = "prod"
}


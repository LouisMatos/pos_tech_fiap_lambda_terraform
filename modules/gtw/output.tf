output "main_url" {
  #value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.lambda_api_gtw.id}/${aws_api_gateway_deployment.prod_deployment.stage_name}/_user_request_"
  value = aws_api_gateway_deployment.prod_deployment.invoke_url
}


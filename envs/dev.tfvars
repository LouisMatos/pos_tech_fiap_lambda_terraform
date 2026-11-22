environment         = "dev"
aws_region          = "us-east-1"
function_name       = "jlapp-lambda-cliente-dev"
dynamodb_table_name = "Customers-dev"
memory_size         = 512
timeout             = 10
lambda_arch         = "arm64" # D7: node t4g.small, imagem da Lambda em arm64

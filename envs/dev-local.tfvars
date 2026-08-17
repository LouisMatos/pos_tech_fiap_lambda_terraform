# terraform apply -var-file=envs/dev-local.tfvars -var="localstack_enabled=true"
environment         = "dev"
aws_region          = "us-east-1"
function_name       = "jlapp-lambda-cliente-dev"
dynamodb_table_name = "Customers-dev"
imagem_name         = "jlapp-lambda:dev-local"
memory_size         = 128
timeout             = 60

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Ambiente (dev/hom/prod) - usado como nome do stage do API Gateway e para nomear a funcao Lambda"
}

variable "dynamodb_table_name" {
  type        = string
  default     = "Customers-dev"
  description = "Nome da tabela DynamoDB (repo pos_tech_fiap_db) que esta Lambda acessa - precisa bater com var.table_name la, por ambiente"
}

variable "function_name" {
  default     = "jlapp-lambda-cliente"
  type        = string
  description = "Name of the Lambda function"
}

variable "imagem_name" {
  default     = "jlapp-lambda:latest"
  type        = string
  description = "Nome do repo ECR + tag da imagem (ex: jlapp-lambda:sha-<commit>). CI sobrescreve via -var em cada deploy."
}

variable "package_type" {
  default     = "Image"
  type        = string
  description = "Type of the package"
}

variable "timeout" {
  default     = 60
  type        = number
  description = "Timeout of the function"
}

variable "memory_size" {
  default     = 128
  type        = number
  description = "Memory size of the function"
}

variable "version_role" {
  default     = "0.0.1"
  type        = string
  description = "Role of the function"
}

variable "name_api_gtw" {
  default     = "jlapp-api-gtw"
  type        = string
  description = "Name of the API Gateway"
}

variable "description_name_api_gtw" {
  default     = "API Gateway for jlapp"
  type        = string
  description = "Description of the API Gateway"
}

variable "path_lambda_pos_tech" {
  default     = "cliente"
  type        = string
  description = "Path of the Lambda"
}
variable "path_lambda_pos_tech_jwt" {
  default     = "jwt"
  type        = string
  description = "Path of the Lambda"
}

variable "path_lambda_pos_tech_cpf" {
  default     = "{cpf}"
  type        = string
  description = "Path of the Lambda"
}

variable "name_role" {
  default     = "jlapp-lambda-role"
  type        = string
  description = "Name of the role"
}
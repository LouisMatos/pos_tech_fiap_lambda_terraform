variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "function_name" {
  default     = "jlapp-lambda-cliente"
  type        = string
  description = "Name of the Lambda function"
}

variable "ecr_repository" {
  default     = "470692656758.dkr.ecr.us-east-1.amazonaws.com"
  type        = string
  description = "Name of the ECR repository"
}

variable "imagem_name" {
  default     = "pos_tech_fiap:latest"
  type        = string
  description = "Name of the image"
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
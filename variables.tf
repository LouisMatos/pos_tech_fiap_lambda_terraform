variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Application Environment, such as dev, prod"
}

variable "aws_profile" {
  type        = string
  default     = "app_deployment_dev"
  description = "AWS profile which is used for the deployment"
}

variable "ecr_repository" {
  type        = string
  default     = "470692656758.dkr.ecr.us-east-1.amazonaws.com"
  description = "Ecr repository for the application"
}

variable "github_run_id" {
  description = "The ID of the GitHub Actions run"
  type        = string
}
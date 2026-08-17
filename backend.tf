# Backend local por padrao (gratis). Hom/prod: terraform init -backend-config=envs/<env>-backend.hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

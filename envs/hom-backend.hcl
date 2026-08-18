bucket         = "postechfiap-tfstate-<account-id>"
key            = "pos_tech_fiap_lambda_terraform/hom/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "postechfiap-tfstate-lock"
encrypt        = true

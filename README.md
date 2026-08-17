# pos_tech_fiap_lambda_terraform

Terraform da Lambda `jlapp-lambda-cliente` (imagem de container via ECR) + API Gateway (`/jwt`, `/cliente`, `/cliente/{cpf}`).

## Ambientes

3 ambientes (dev/hom/prod). `var.environment` também nomeia o stage do API Gateway (antes era sempre `prod` fixo). Ver `envs/`.

## Uso contra AWS real

```bash
terraform init -backend-config=envs/hom-backend.hcl
terraform workspace select -or-create hom
terraform apply -var-file=envs/hom.tfvars
```

## Uso local contra LocalStack

Lambda + IAM + API Gateway são totalmente suportados pelo LocalStack Community:

```bash
docker compose -f docker-compose.localstack.yml up -d
terraform init
terraform apply -var-file=envs/dev-local.tfvars -var="localstack_enabled=true" -auto-approve
terraform destroy -var-file=envs/dev-local.tfvars -var="localstack_enabled=true" -auto-approve
docker compose -f docker-compose.localstack.yml down
```

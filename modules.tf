module "master" {
  source = "./modules/master"

  aws_region   = var.aws_region
  version_role = var.version_role

  function_name  = var.function_name
  ecr_repository = var.ecr_repository
  imagem_name    = var.imagem_name
  package_type   = var.package_type

  timeout = var.timeout

  memory_size = var.memory_size
}


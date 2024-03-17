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

module "gtw" {
  source = "./modules/gtw"

  name_role =   var.name_role

  name_api_gtw             = var.name_api_gtw
  description_name_api_gtw = var.description_name_api_gtw
  path_lambda_pos_tech     = var.path_lambda_pos_tech
  jlapp_lambda             = module.master.jlapp_lambda

}


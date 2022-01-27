terraform {
  required_providers {
    aws = {
      version = ">=3.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  access_key = var.access_key_id
  secret_key = var.secret_access_key
  region     = "eu-central-1"
}

module "networking" {
  count = var.networking ? 1 : 0

  source = "./networking"

  tag_prefix  = var.tag_prefix
  my_ip       = var.my_ip
  vpc_cidr    = var.vpc_cidr
  subnet_data = var.subnet_data
}

module "secret_ssm" {
  count = var.secret_ssm ? 1 : 0

  source = "./secret_ssm"

  tag_prefix = var.tag_prefix
  db_passwd  = var.db_passwd
  access_key_id     = var.access_key_id
  secret_access_key = var.secret_access_key
}

module "database" {
  count = var.database ? 1 : 0

  source = "./database"

  tag_prefix = var.tag_prefix
  db_subnet_ids = [
    module.networking[0].database_subnet_az1_id,
    module.networking[0].database_subnet_az2_id,
    module.networking[0].database_subnet_az3_id
  ]
  db_allocated_storage = var.db_allocated_storage
  db_instance_type     = var.db_instance_type
  db_passwd_name       = module.secret_ssm[0].db_passwd_name
  db_security_group_id = module.networking[0].database_sg_id
  db_availability_zone = var.db_availability_zone
  db_user              = var.db_user
  db_name              = var.db_name

  depends_on = [module.secret_ssm]
}

module "iam" {
  count = var.iam ? 1 : 0

  source = "./iam"

  tag_prefix = var.tag_prefix
}

module "key_pair" {
  count = var.key_pair ? 1 : 0

  source = "./key_pair"

  tag_prefix = var.tag_prefix
  key_name   = var.key_name
}

module "provisioner_instance" {
  count = var.provisioner_instance ? 1 : 0

  source = "./provisioner_instance"

  tag_prefix                        = var.tag_prefix
  key_pair_name                     = var.key_pair ? module.key_pair[0].key_pair_name : var.instance_key_name
  provisioner_ami                   = var.provisioner_ami
  provisioner_instance_profile_name = module.iam[0].provisioner_instance_profile_name
  provisioner_security_group_id     = module.networking[0].provisioner_instance_sg_id
  provisioner_subnet_id             = module.networking[0].public_subnet_az1_id
}

module "efs" {
  count = var.efs ? 1 : 0

  source = "./efs"

  tag_prefix = var.tag_prefix
  subnet_ids = [
    module.networking[0].public_subnet_az1_id,
    module.networking[0].public_subnet_az2_id,
    module.networking[0].public_subnet_az3_id
  ]
  efs_security_group = module.networking[0].efs_sg_id
}

module "ecr" {
  count = var.ecr ? 1 : 0

  source = "./ecr"

  tag_prefix               = var.tag_prefix
  docker_image_name        = var.docker_image_name
  docker_image_tag         = var.docker_image_tag
  aws_account_id           = var.aws_account_id
  region                   = var.region
  access_key_id_secret_name            = module.secret_ssm[0].access_key_id_name
  secret_access_key_secret_name       = module.secret_ssm[0].secret_access_key_name

  depends_on = [module.provisioner_instance]
}

module "load_balancer" {
  count = var.load_balancer ? 1 : 0

  source = "./load_balancer"

  tag_prefix                      = var.tag_prefix
  vpc_id                          = module.networking[0].vpc_id
  load_balancer_security_group_id = module.networking[0].load_balancer_sg_id
  public_subnet_ids = [
    module.networking[0].public_subnet_az1_id,
    module.networking[0].public_subnet_az2_id,
    module.networking[0].public_subnet_az3_id
  ]
}

module "vpc_endpoints" {
  count = var.vpc_endpoints ? 1 : 0

  source = "./vpc_endpoints"

  tag_prefix              = var.tag_prefix
  vpc_id                  = module.networking[0].vpc_id
  endpoint_security_group = module.networking[0].vpc_endpoint_sg_id
  region                  = var.region
  subnet_ids = [
    module.networking[0].fargate_subnet_az1_id,
    module.networking[0].fargate_subnet_az2_id,
    module.networking[0].fargate_subnet_az3_id
  ]
  gateway_endpoint_rt_id = module.networking[0].private_route_table_id
}

module "confluence_fargate" {
  count = var.confluence_fargate ? 1 : 0

  source = "./confluence_fargate"

  tag_prefix = var.tag_prefix
  region     = var.region

  fargate_log_group_exists         = var.fargate_log_group_exists
  fargate_log_group_retention_days = var.fargate_log_group_retention_days

  number_of_tasks = var.number_of_tasks

  task_def_execution_role_arn = module.iam[0].task_definition_role_arn
  task_def_task_role_arn      = module.iam[0].task_definition_role_arn
  container_cpu_constraint    = var.container_cpu_constraint
  container_memory_constraint = var.container_memory_constraint
  container_volume_efs_id     = module.efs[0].efs_id
  container_image             = module.ecr[0].ecr_image_tag
  container_lb_dns_name       = module.load_balancer[0].load_balancer_dns_name
  container_db_url            = module.database[0].db_endpoint
  container_db_name           = module.database[0].db_name
  container_db_user           = module.database[0].db_username
  container_db_passwd_name    = module.secret_ssm[0].db_passwd_name
  licence_key                 = var.licence_key
  target_group_arn            = module.load_balancer[0].target_group_confluence_arn
  fargate_subnet_ids = [
    module.networking[0].fargate_subnet_az1_id,
    module.networking[0].fargate_subnet_az2_id,
    module.networking[0].fargate_subnet_az3_id
  ]
  server_security_group_id = module.networking[0].server_sg_id

  depends_on = [module.secret_ssm, module.ecr, module.provisioner_instance]
}

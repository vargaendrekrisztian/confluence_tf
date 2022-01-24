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
  count = var.networking == true ? 1 : 0

  source = "./networking"

  my_ip       = var.my_ip
  vpc_cidr    = var.vpc_cidr
  tag_prefix  = var.tag_prefix
  subnet_data = var.subnet_data
}

module "secret_ssm" {
  count = var.secret_ssm == true ? 1 : 0

  source = "./secret_ssm"

  db_passwd  = var.db_passwd
  tag_prefix = var.tag_prefix
}

module "database" {
  count = var.database == true ? 1 : 0

  source = "./database"

  tag_prefix = var.tag_prefix
  db_subnet_ids = [
    module.networking[0].private_subnet_az1_id,
    module.networking[0].private_subnet_az2_id,
    module.networking[0].private_subnet_az3_id
  ]
  db_allocated_storage = var.db_allocated_storage
  db_engine            = var.db_engine
  db_engine_version    = var.db_engine_version
  db_instance_type     = var.db_instance_type
  db_passwd_name       = module.secret_ssm[0].db_passwd_name
  db_port              = var.db_port
  db_security_group_id = module.networking[0].database_sg_id
  db_availability_zone = var.db_availability_zone
  db_user              = var.db_user
  db_name              = var.db_name

  depends_on = [module.secret_ssm]
}

module "iam" {
  count = var.iam == true ? 1 : 0

  source = "./iam"

  tag_prefix                            = var.tag_prefix
  iam_task_definition_role_name         = var.iam_task_definition_role_name
  iam_provisioner_instance_role_name    = var.iam_provisioner_instance_role_name
  iam_provisioner_instance_profile_name = var.iam_provisioner_instance_profile_name
}

module "key_pair" {
  count = var.key_pair == true ? 1 : 0

  source = "./key_pair"

  tag_prefix = var.tag_prefix
  key_name   = var.key_name
}

module "provisioner_instance" {
  count = var.provisioner_instance == true ? 1 : 0

  source = "./provisioner_instance"

  tag_prefix                        = var.tag_prefix
  key_pair_name                     = var.key_pair ? module.key_pair[0].key_pair_name : var.instance_key_name
  provisioner_ami                   = var.provisioner_ami
  provisioner_instance_profile_name = var.iam_provisioner_instance_profile_name
  provisioner_security_group_id     = module.networking[0].provisioner_instance_sg_id
  provisioner_subnet_id             = module.networking[0].public_subnet_az1_id
}

module "efs" {
  count = var.efs == true ? 1 : 0

  source = "./efs"

  tag_prefix = var.tag_prefix
  efs_name   = var.efs_name
  subnet_ids = [
    module.networking[0].public_subnet_az1_id,
    module.networking[0].public_subnet_az2_id,
    module.networking[0].public_subnet_az3_id
  ]
  efs_security_group = module.networking[0].efs_sg_id
}

module "ecr" {
  count = var.ecr == true ? 1 : 0

  source = "./ecr"

  tag_prefix               = var.tag_prefix
  ecr_repo_name            = var.ecr_repo_name
  ecr_image_tag_mutability = var.ecr_image_tag_mutability
  docker_image_name        = var.docker_image_name
  docker_image_tag         = var.docker_image_tag
  aws_account_id           = var.aws_account_id
  region                   = var.region
  access_key_id            = var.access_key_id
  secret_access_key        = var.secret_access_key

  depends_on = [module.provisioner_instance]
}

module "load_balancer" {
  count = var.load_balancer == true ? 1 : 0

  source = "./load_balancer"

  tag_prefix                      = var.tag_prefix
  vpc_id                          = module.networking[0].vpc_id
  target_group_name               = var.target_group_name
  confluence_port                 = var.confluence_port
  load_balancer_name              = var.load_balancer_name
  load_balancer_security_group_id = module.networking[0].load_balancer_sg_id
  public_subnet_ids = [
    module.networking[0].public_subnet_az1_id,
    module.networking[0].public_subnet_az2_id,
    module.networking[0].public_subnet_az3_id
  ]
  load_balancer_listener_port = var.load_balancer_listener_port
}

module "vpc_endpoints" {
  count = var.vpc_endpoints == true ? 1 : 0

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
  count = var.confluence_fargate == true ? 1 : 0

  source = "./confluence_fargate"

  tag_prefix = var.tag_prefix
  region     = var.region

  fargate_log_group_exists         = var.fargate_log_group_exists
  fargate_log_group_name           = var.fargate_log_group_name
  fargate_log_group_retention_days = var.fargate_log_group_retention_days

  cluster_name    = var.cluster_name
  number_of_tasks = var.number_of_tasks

  task_def_service_name       = var.task_def_service_name
  task_def_execution_role_arn = module.iam[0].task_definition_role_arn
  task_def_task_role_arn      = module.iam[0].task_definition_role_arn
  container_cpu_constraint    = var.container_cpu_constraint
  container_memory_constraint = var.container_memory_constraint
  container_volume_efs_name   = var.efs_name
  container_volume_efs_id     = module.efs[0].efs_id
  container_name              = var.container_name
  container_image             = module.ecr[0].ecr_image_tag
  container_port              = var.confluence_port
  container_db_client_type    = var.db_engine == "postgres" ? "postgresql" : var.db_engine
  container_db_url            = module.database[0].db_endpoint
  container_db_name           = module.database[0].db_name
  container_db_user           = module.database[0].db_username
  container_db_passwd_name    = module.secret_ssm[0].db_passwd_name
  licence_key                 = var.licence_key
  target_group_arn            = module.load_balancer[0].target_group_arn
  fargate_subnet_ids = [
    module.networking[0].fargate_subnet_az1_id,
    module.networking[0].fargate_subnet_az2_id,
    module.networking[0].fargate_subnet_az3_id
  ]
  server_security_group_id = module.networking[0].server_sg_id

  depends_on = [module.secret_ssm, module.provisioner_instance]
}

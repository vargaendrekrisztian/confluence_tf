# NETWORKING
output "vpc_id" {
  value = var.networking ? module.networking[0].vpc_id : null
  depends_on = [module.networking]
}
output "igw_id" {
  value = var.networking ? module.networking[0].igw_id : null
  depends_on = [module.networking]
}
output "public_subnet_az1_id" {
  value = var.networking ? module.networking[0].public_subnet_az1_id : null
  depends_on = [module.networking]
}
output "public_subnet_az2_id" {
  value = var.networking ? module.networking[0].public_subnet_az2_id : null
  depends_on = [module.networking]
}
output "public_subnet_az3_id" {
  value = var.networking ? module.networking[0].public_subnet_az3_id : null
  depends_on = [module.networking]
}
output "database_subnet_az1_id" {
  value = var.networking ? module.networking[0].database_subnet_az1_id : null
  depends_on = [module.networking]
}
output "database_subnet_az2_id" {
  value = var.networking ? module.networking[0].database_subnet_az2_id : null
  depends_on = [module.networking]
}
output "database_subnet_az3_id" {
  value = var.networking ? module.networking[0].database_subnet_az3_id : null
  depends_on = [module.networking]
}
output "public_route_table_id" {
  value = var.networking ? module.networking[0].public_route_table_id : null
  depends_on = [module.networking]
}
output "private_route_table_id" {
  value = var.networking ? module.networking[0].private_route_table_id : null
  depends_on = [module.networking]
}
output "server_sg_id" {
  value = var.networking ? module.networking[0].server_sg_id : null
  depends_on = [module.networking]
}
output "database_sg_id" {
  value = var.networking ? module.networking[0].database_sg_id : null
  depends_on = [module.networking]
}
output "load_balancer_sg_id" {
  value = var.networking ? module.networking[0].load_balancer_sg_id : null
  depends_on = [module.networking]
}
output "efs_sg_id" {
  value = var.networking ? module.networking[0].efs_sg_id : null
  depends_on = [module.networking]
}
output "vpc_endpoint_sg_id" {
  value = var.networking ? module.networking[0].vpc_endpoint_sg_id : null
  depends_on = [module.networking]
}
output "provisioner_instance_sg_id" {
  value = var.networking ? module.networking[0].provisioner_instance_sg_id : null
  depends_on = [module.networking]
}

# SSM PARAMETER
output "db_passwd_name" {
  value = var.secret_ssm ? module.secret_ssm[0].db_passwd_name : null
  depends_on = [module.secret_ssm]
}
output "db_passwd_arn" {
  value = var.secret_ssm ? module.secret_ssm[0].db_passwd_arn : null
  depends_on = [module.secret_ssm]
}

# DATABASE
output "db_address" {
  value = var.database ? module.database[0].db_address : null
  depends_on = [module.database]
}
output "db_endpoint" {
  value = var.database ? module.database[0].db_endpoint : null
  depends_on = [module.database]
}
output "db_availability_zone" {
  value = var.database ? module.database[0].db_availability_zone : null
  depends_on = [module.database]
}
output "db_instance_id" {
  value = var.database ? module.database[0].db_instance_id : null
  depends_on = [module.database]
}
output "db_name" {
  value = var.database ? module.database[0].db_name : null
  depends_on = [module.database]
}
output "db_port" {
  value = var.database ? module.database[0].db_port : null
  depends_on = [module.database]
}
output "db_username" {
  value = var.database ? module.database[0].db_username : null
  depends_on = [module.database]
}

# KEY PAIR
output "key_pair_name" {
  value = var.key_pair ? module.key_pair[0].key_pair_name : null
  depends_on = [module.key_pair]
}

# PROVISIONER INSTANCE
output "provisioner_instance_id" {
  value = var.provisioner_instance ? module.provisioner_instance[0].provisioner_instance_id : null
  depends_on = [module.provisioner_instance]
}

# ECR
output "ecr_registry_id" {
  value = var.ecr ? module.ecr[0].ecr_registry_id : null
  depends_on = [module.ecr]
}
output "ecr_repository_url" {
  value = var.ecr ? module.ecr[0].ecr_repository_url : null
  depends_on = [module.ecr]
}
output "ecr_image_tag" {
  value = var.ecr ? module.ecr[0].ecr_image_tag : null
  depends_on = [module.ecr]
}

# IAM
output "task_definition_role_arn" {
  value = var.iam ? module.iam[0].task_definition_role_arn : null
  depends_on = [module.iam]
}
output "task_definition_role_name" {
  value = var.iam ? module.iam[0].task_definition_role_name : null
  depends_on = [module.iam]
}
output "provisioner_instance_role_arn" {
  value = var.iam ? module.iam[0].provisioner_instance_role_arn : null
  depends_on = [module.iam]
}
output "provisioner_instance_role_name" {
  value = var.iam ? module.iam[0].provisioner_instance_role_name : null
  depends_on = [module.iam]
}

# EFS
output "efs_id" {
  value = var.efs ? module.efs[0].efs_id : null
  depends_on = [module.efs]
}

# LOAD BALANCER
output "load_balancer_arn" {
  value = var.load_balancer ? module.load_balancer[0].load_balancer_arn : null
  depends_on = [module.load_balancer]
}
output "load_balancer_dns_name" {
  value = var.load_balancer ? module.load_balancer[0].load_balancer_dns_name : null
  depends_on = [module.load_balancer]
}
output "target_group_confluence_arn" {
  value = var.load_balancer ? module.load_balancer[0].target_group_confluence_arn : null
  depends_on = [module.load_balancer]
}
output "target_group_synchrony_arn" {
  value = var.load_balancer ? module.load_balancer[0].target_group_synchrony_arn : null
  depends_on = [module.load_balancer]
}

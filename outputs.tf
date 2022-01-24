# NETWORKING
output "vpc_id" {
  value = var.networking ? module.networking[0].vpc_id : null
}
output "igw_id" {
  value = var.networking ? module.networking[0].igw_id : null
}
output "public_subnet_az1_id" {
  value = var.networking ? module.networking[0].public_subnet_az1_id : null
}
output "public_subnet_az2_id" {
  value = var.networking ? module.networking[0].public_subnet_az2_id : null
}
output "public_subnet_az3_id" {
  value = var.networking ? module.networking[0].public_subnet_az3_id : null
}
output "private_subnet_az1_id" {
  value = var.networking ? module.networking[0].private_subnet_az1_id : null
}
output "private_subnet_az2_id" {
  value = var.networking ? module.networking[0].private_subnet_az2_id : null
}
output "private_subnet_az3_id" {
  value = var.networking ? module.networking[0].private_subnet_az3_id : null
}
output "public_route_table_id" {
  value = var.networking ? module.networking[0].public_route_table_id : null
}
output "private_route_table_id" {
  value = var.networking ? module.networking[0].private_route_table_id : null
}
output "server_sg_id" {
  value = var.networking ? module.networking[0].server_sg_id : null
}
output "database_sg_id" {
  value = var.networking ? module.networking[0].database_sg_id : null
}
output "load_balancer_sg_id" {
  value = var.networking ? module.networking[0].load_balancer_sg_id : null
}
output "efs_sg_id" {
  value = var.networking ? module.networking[0].efs_sg_id : null
}
output "vpc_endpoint_sg_id" {
  value = var.networking ? module.networking[0].vpc_endpoint_sg_id : null
}
output "provisioner_instance_sg_id" {
  value = var.networking ? module.networking[0].provisioner_instance_sg_id : null
}

# SSM PARAMETER
output "db_passwd_name" {
  value = var.secret_ssm ? module.secret_ssm[0].db_passwd_name : null
}
output "db_passwd_arn" {
  value = var.secret_ssm ? module.secret_ssm[0].db_passwd_arn : null
}

# DATABASE
output "db_address" {
  value = var.database ? module.database[0].db_address : null
}
output "db_endpoint" {
  value = var.database ? module.database[0].db_endpoint : null
}
output "db_availability_zone" {
  value = var.database ? module.database[0].db_availability_zone : null
}
output "db_instance_id" {
  value = var.database ? module.database[0].db_instance_id : null
}
output "db_name" {
  value = var.database ? module.database[0].db_name : null
}
output "db_port" {
  value = var.database ? module.database[0].db_port : null
}
output "db_username" {
  value = var.database ? module.database[0].db_username : null
}

# KEY PAIR
output "key_pair_name" {
  value = var.key_pair ? module.key_pair[0].key_pair_name : null
}

# PROVISIONER INSTANCE
output "provisioner_instance_id" {
  value = var.provisioner_instance ? module.provisioner_instance[0].provisioner_instance_id : null
}

# ECR
output "ecr_arn" {
  value = var.ecr ? module.ecr[0].ecr_arn : null
}
output "ecr_registry_id" {
  value = var.ecr ? module.ecr[0].ecr_registry_id : null
}
output "ecr_repository_url" {
  value = var.ecr ? module.ecr[0].ecr_repository_url : null
}
output "ecr_image_tag" {
  value = var.ecr ? module.ecr[0].ecr_image_tag : null
}

# IAM
output "task_definition_role_arn" {
  value = var.iam ? module.iam[0].task_definition_role_arn : null
}
output "task_definition_role_id" {
  value = var.iam ? module.iam[0].task_definition_role_id : null
}
output "task_definition_role_name" {
  value = var.iam ? module.iam[0].task_definition_role_name : null
}
output "task_definition_role_unique_id" {
  value = var.iam ? module.iam[0].task_definition_role_unique_id : null
}
output "provisioner_instance_role_arn" {
  value = var.iam ? module.iam[0].provisioner_instance_role_arn : null
}
output "provisioner_instance_role_id" {
  value = var.iam ? module.iam[0].provisioner_instance_role_id : null
}
output "provisioner_instance_role_name" {
  value = var.iam ? module.iam[0].provisioner_instance_role_name : null
}
output "provisioner_instance_role_unique_id" {
  value = var.iam ? module.iam[0].provisioner_instance_role_unique_id : null
}

# EFS
output "efs_id" {
  value = var.efs ? module.efs[0].efs_id : null
}

# LOAD BALANCER
output "load_balancer_arn" {
  value = var.load_balancer ? module.load_balancer[0].load_balancer_arn : null
}
output "load_balancer_dns_name" {
  value = var.load_balancer ? module.load_balancer[0].load_balancer_dns_name : null
}
output "target_group_arn" {
  value = var.load_balancer ? module.load_balancer[0].target_group_arn : null
}

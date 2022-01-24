# CREDENTIALS
variable "access_key_id" {
  type      = string
  sensitive = true
}
variable "secret_access_key" {
  type      = string
  sensitive = true
}

# MODULE NEABLEMENTS
variable "networking" {
  type = bool
}
variable "iam" {
  type = bool
}
variable "secret_ssm" {
  type = bool
}
variable "database" {
  type = bool
}
variable "key_pair" {
  type = bool
}
variable "provisioner_instance" {
  type = bool
}
variable "ecr" {
  type = bool
}
variable "efs" {
  type = bool
}
variable "vpc_endpoints" {
  type = bool
}
variable "load_balancer" {
  type = bool
}
variable "confluence_fargate" {
  type = bool
}

# NETWORKING
variable "my_ip" {}
variable "vpc_cidr" {}
variable "tag_prefix" {}
variable "subnet_data" {}

# SSM_PARAMETER
variable "db_passwd" {}

# DATABASE
variable "db_allocated_storage" {}
variable "db_engine" {}
variable "db_engine_version" {}
variable "db_instance_type" {}
variable "db_passwd_name" {}
variable "db_port" {}
variable "db_availability_zone" {}
variable "db_user" {}
variable "db_name" {}

# KEY PAIR
variable "instance_key_name" {
  type    = string
  default = ""
}

# PROVISIONER INSTANCE
variable "provisioner_ami" {}
variable "key_name" {}

# ECR
variable "ecr_repo_name" {}
variable "ecr_image_tag_mutability" {}
variable "docker_image_name" {}
variable "docker_image_tag" {}
variable "aws_account_id" {}
variable "region" {}

# IAM
variable "iam_task_definition_role_name" {}
variable "iam_provisioner_instance_role_name" {}
variable "iam_provisioner_instance_profile_name" {}

# EFS
variable "efs_name" {}

# LOAD BALANCER
variable "target_group_name" {}
variable "confluence_port" {}
variable "load_balancer_name" {}
variable "load_balancer_listener_port" {}

# CONFLUENCE FARGATE
variable "fargate_log_group_exists" {}
variable "fargate_log_group_name" {}
variable "fargate_log_group_retention_days" {}
variable "cluster_name" {}
variable "number_of_tasks" {}
variable "task_def_service_name" {}
variable "container_cpu_constraint" {}
variable "container_memory_constraint" {}
variable "container_name" {}
variable "licence_key" {}

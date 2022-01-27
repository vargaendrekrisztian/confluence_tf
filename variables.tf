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
variable "db_instance_type" {}
variable "db_availability_zone" {}
variable "db_user" {}
variable "db_name" {}

# KEY PAIR
variable "key_name" {}

# PROVISIONER INSTANCE
variable "provisioner_ami" {}
variable "instance_key_name" {
  default = ""
}

# ECR
variable "docker_image_name" {}
variable "docker_image_tag" {}
variable "aws_account_id" {}
variable "region" {}

# CONFLUENCE FARGATE
variable "fargate_log_group_exists" {}
variable "fargate_log_group_retention_days" {}
variable "number_of_tasks" {}
variable "container_cpu_constraint" {}
variable "container_memory_constraint" {}
variable "licence_key" {
  type = string
  sensitive = true
}

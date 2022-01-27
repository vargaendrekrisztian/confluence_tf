variable "tag_prefix" {
  type = string
}
variable "region" {
  type = string
}
variable "target_group_arn" {
  type = string
}
variable "fargate_subnet_ids" {
  type = list(string)
}
variable "fargate_log_group_exists" {
  type = bool
}
variable "fargate_log_group_retention_days" {
  type = number

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.fargate_log_group_retention_days)
    error_message = "Valid numbers of retention days are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653."
  }
}
variable "number_of_tasks" {
  type = number
}
variable "task_def_execution_role_arn" {
  type = string
}
variable "task_def_task_role_arn" {
  type = string
}
variable "container_cpu_constraint" {
  type = number
}
variable "container_memory_constraint" {
  type = number
}
variable "container_volume_efs_id" {
  type = string
}
variable "container_image" {
  type = string
}
variable "container_lb_dns_name" {
  type = string
}
variable "container_db_url" {
  type = string
}
variable "container_db_user" {
  type = string
}
variable "container_db_passwd_name" {
  type = string
}
variable "container_db_name" {
  type = string
}
variable "licence_key" {
  type = string
}
variable "server_security_group_id" {
  type = string
}

variable "tag_prefix" {
  type = string
}
variable "db_subnet_ids" {
  type = list(string)
}
variable "db_allocated_storage" {
  type = number
}
variable "db_instance_type" {
  type = string
  description = "Instance types are limited to the following: .db.t2.micro, db.t2.small, db.t2.medium"

  validation {
    condition     = contains(["db.t2.micro", "db.t2.small", "db.t2.medium"], var.db_instance_type)
    error_message = "Invalid database instance type. Valid values: db.t2.micro, db.t2.small, db.t2.medium."
  }
}
variable "db_passwd_name" {
  type = string
}
variable "db_security_group_id" {
  type = string
}
variable "db_availability_zone" {
  type = string

  validation {
    condition     = can(regex("[a-z]{2}-[a-z]+-\\d[a-z]", var.db_availability_zone))
    error_message = "Invalid availability zone name. Valid format (regex): [a-z]{2}-[a-z]+-\\d[a-z]."
  }
}
variable "db_user" {
  type = string
}
variable "db_name" {
  type = string
}

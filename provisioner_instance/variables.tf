variable "tag_prefix" {
  type = string
}
variable "key_pair_name" {
  type = string
}
variable "provisioner_ami" {
  type = string

  validation {
    condition     = can(regex("ami-[a-z0-9]{17}", var.provisioner_ami))
    error_message = "Invalid AMI ID. Valid format (regex): ami-[a-z0-9]{17}."
  }
}
variable "provisioner_security_group_id" {
  type = string
}
variable "provisioner_subnet_id" {
  type = string
}
variable "provisioner_instance_profile_name" {
  type = string
}

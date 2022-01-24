variable "tag_prefix" {
  type = string
}

variable "efs_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "efs_security_group" {
  type = string
}

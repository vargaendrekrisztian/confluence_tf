variable "tag_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "confluence_port" {
  type = number
}

variable "load_balancer_name" {
  type = string
}

variable "load_balancer_security_group_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "load_balancer_listener_port" {
  type = number
}

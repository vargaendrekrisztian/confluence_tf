variable "tag_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "endpoint_security_group" {
  type = string
}

variable "region" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "gateway_endpoint_rt_id" {
  type = string
}

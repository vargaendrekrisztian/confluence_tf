variable "tag_prefix" {
  type = string
}

variable "ecr_repo_name" {
  type = string
}

variable "ecr_image_tag_mutability" {
  type = string

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.ecr_image_tag_mutability)
    error_message = "Invalid image mutability value. Valid values: MUTABLE, IMMUTABLE."
  }
}

variable "docker_image_name" {
  type = string
}

variable "docker_image_tag" {
  type = string
}

variable "access_key_id" {
  type = string
}

variable "secret_access_key" {
  type = string
}

variable "aws_account_id" {
  type = number

  validation {
    condition     = length(tostring(var.aws_account_id)) == 12
    error_message = "AWS account IDs have 12-digit length exactly."
  }
}

variable "region" {
  type = string

  validation {
    condition     = can(regex("[a-z]{2}-[a-z]+-[0-9]", var.region))
    error_message = "Invalid region. Valid region format (regex): [a-z]{2}-[a-z]+-[0-9]. For example: \"eu-central-1\"."
  }
}

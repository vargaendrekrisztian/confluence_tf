variable "tag_prefix" {
  type = string
}
variable "docker_image_name" {
  type = string
}
variable "docker_image_tag" {
  type = string
}
variable "access_key_id_secret_name" {
  type = string
}
variable "secret_access_key_secret_name" {
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

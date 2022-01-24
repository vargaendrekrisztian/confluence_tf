variable "tag_prefix" {
  type = string
}

variable "db_passwd" {
  type      = string
  sensitive = true
}

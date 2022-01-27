variable "tag_prefix" {
  type = string
}
variable "db_passwd" {
  type      = string
  sensitive = true
}
variable "access_key_id" {
  type      = string
  sensitive = true
}
variable "secret_access_key" {
  type      = string
  sensitive = true
}

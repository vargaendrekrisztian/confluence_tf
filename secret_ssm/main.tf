resource "aws_ssm_parameter" "db_passwd" {
  name        = "/confluence/db_passwd"
  description = "Parameter with encrypted string for database password."
  type        = "SecureString"
  value       = var.db_passwd

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "db",
      "passwd"
    ])
  }
}

resource "aws_ssm_parameter" "access_key_id" {
  name        = "/confluence/access_key_id"
  description = "Parameter with encrypted string for AWS access kez ID."
  type        = "SecureString"
  value       = var.access_key_id

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "access",
      "key",
      "id"
    ])
  }
}

resource "aws_ssm_parameter" "secret_access_key" {
  name        = "/confluence/secret_access_key"
  description = "Parameter with encrypted string for AWS secret access key."
  type        = "SecureString"
  value       = var.secret_access_key

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "secret",
      "access",
      "key"
    ])
  }
}

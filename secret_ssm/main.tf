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

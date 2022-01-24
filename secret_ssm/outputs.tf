output "db_passwd_name" {
  value = aws_ssm_parameter.db_passwd.name
}
output "db_passwd_arn" {
  value = aws_ssm_parameter.db_passwd.arn
}

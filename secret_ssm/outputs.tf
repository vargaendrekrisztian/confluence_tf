output "db_passwd_name" {
  value = aws_ssm_parameter.db_passwd.name
}
output "db_passwd_arn" {
  value = aws_ssm_parameter.db_passwd.arn
}
output "access_key_id_name" {
  value = aws_ssm_parameter.access_key_id.name
}
output "access_key_id_arn" {
  value = aws_ssm_parameter.access_key_id.arn
}
output "secret_access_key_name" {
  value = aws_ssm_parameter.secret_access_key.name
}
output "secret_access_key_arn" {
  value = aws_ssm_parameter.secret_access_key.arn
}

output "task_definition_role_arn" {
  value = aws_iam_role.task_definition_role.arn
}

output "task_definition_role_id" {
  value = aws_iam_role.task_definition_role.id
}

output "task_definition_role_name" {
  value = aws_iam_role.task_definition_role.name
}

output "task_definition_role_unique_id" {
  value = aws_iam_role.task_definition_role.unique_id
}

output "provisioner_instance_role_arn" {
  value = aws_iam_role.provisioner_instance_role.arn
}

output "provisioner_instance_role_id" {
  value = aws_iam_role.provisioner_instance_role.id
}

output "provisioner_instance_role_name" {
  value = aws_iam_role.provisioner_instance_role.name
}

output "provisioner_instance_role_unique_id" {
  value = aws_iam_role.provisioner_instance_role.unique_id
}

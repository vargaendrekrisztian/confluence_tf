output "ecr_registry_id" {
  value = aws_ecr_repository.ecr.registry_id
}
output "ecr_repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}
output "ecr_image_tag" {
  value = local.docker_tagged_image_name
}

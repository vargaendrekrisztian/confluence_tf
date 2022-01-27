data "aws_ssm_parameter" "access_key_id" {
  name = var.access_key_id_secret_name
}

data "aws_ssm_parameter" "secret_access_key" {
  name = var.secret_access_key_secret_name
}

resource "aws_ecr_repository" "ecr" {
  name                 = join("-", [var.tag_prefix, "repo"])
  image_tag_mutability = "MUTABLE"

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "repo"
    ])
  }
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr.name
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [{
        Sid       = "AllowPushPull"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }]
    }
  )
}

locals {
  docker_image_ref = join(":", [var.docker_image_name, var.docker_image_tag])
  docker_tagged_image_name = join(":", [
    aws_ecr_repository.ecr.repository_url,
    var.docker_image_tag
  ])
}

resource "local_file" "ecr_docker_playbook" {
  content = templatefile(
    "${path.root}/ansible_files/ecr_docker.yml.tpl",
    {
      access_key_id     = data.aws_ssm_parameter.access_key_id.value
      secret_access_key = data.aws_ssm_parameter.secret_access_key.value
      original_image    = var.docker_image_tag != "" ? local.docker_image_ref : var.docker_image_name
      ecr_image_name    = local.docker_tagged_image_name
      account_id        = var.aws_account_id
      region            = var.region
    }
  )
  filename = "${path.root}/ansible_files/ecr_docker.yml"
}

resource "null_resource" "docker" {
  triggers = {
    ecr_repo_url = aws_ecr_repository.ecr.repository_url
  }

  provisioner "local-exec" {
    working_dir = "./ansible_files"
    command     = "ansible-playbook -i inventory ecr_docker.yml"
  }

  depends_on = [local_file.ecr_docker_playbook]
}

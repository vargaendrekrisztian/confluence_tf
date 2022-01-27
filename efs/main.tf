resource "aws_efs_file_system" "efs" {
  creation_token = join("-", [var.tag_prefix, "efs"])
  encrypted      = false

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "efs"
    ])
  }
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.efs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "FullAccessEFSPolicy"
    Statement = [{
      Sid       = "FullAccessStatement"
      Effect    = "Allow"
      Principal = "*"
      Resource  = "*"
      Action    = ["*"]
    }]
  })
}

resource "aws_efs_mount_target" "mount_targets" {
  count = length(var.subnet_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.efs_security_group]
}

resource "aws_efs_file_system" "efs" {
  creation_token = var.efs_name
  encrypted      = false

  tags = {
    Name = join("-", [
      var.tag_prefix,
      var.efs_name
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

/* resource "aws_efs_access_point" "access_point" {
  file_system_id = aws_efs_file_system.efs.id
  posix_user {
    uid = 2002
    gid = 2002
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "confluence",
      "efs",
      "access",
      "point"
    ])
  }
} */

resource "aws_efs_mount_target" "mount_targets" {
  count = length(var.subnet_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.efs_security_group]
}

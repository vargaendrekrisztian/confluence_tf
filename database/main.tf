data "aws_ssm_parameter" "db_password" {
  name            = var.db_passwd_name
  with_decryption = true
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = var.tag_prefix
  subnet_ids = [for subnet in var.db_subnet_ids : subnet]

  tags = {
    "Name" = join("-", [var.tag_prefix, "db", "subnet", "group"])
  }
}

resource "aws_db_instance" "database" {
  identifier        = join("-", [var.tag_prefix, "db", "postgres"])
  instance_class    = var.db_instance_type
  allocated_storage = var.db_allocated_storage

  engine         = "postgres"
  engine_version = "10.15"
  port           = "5432"

  username = var.db_user
  name     = var.db_name
  password = data.aws_ssm_parameter.db_password.value

  # These database backup settings are just for testing. It is not recommended to use them in prodution.
  backup_retention_period = 0
  skip_final_snapshot     = true

  availability_zone      = var.db_availability_zone
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = [var.db_security_group_id]
}

# INTERFACE ENDPOINTS
resource "aws_vpc_endpoint" "interface_vpc_endpoint_ssm" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "ssm"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "ssm"
    ])
  }
}

resource "aws_vpc_endpoint" "interface_vpc_endpoint_secretsmanager" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "secretsmanager"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "secretsmanager"
    ])
  }
}

resource "aws_vpc_endpoint" "interface_vpc_endpoint_ecr_dkr" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "ecr.dkr"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "ecrdkr"
    ])
  }
}

resource "aws_vpc_endpoint" "interface_vpc_endpoint_ecr_api" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "ecr.api"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "ecrapi"
    ])
  }
}

resource "aws_vpc_endpoint" "interface_vpc_endpoint_elasticfilesystem" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "elasticfilesystem"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "elasticfilesystem"
    ])
  }
}

resource "aws_vpc_endpoint" "interface_vpc_endpoint_logs" {
  vpc_id             = var.vpc_id
  service_name       = join(".", ["com", "amazonaws", var.region, "logs"])
  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.endpoint_security_group]
  subnet_ids         = var.subnet_ids

  private_dns_enabled = true

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "logs"
    ])
  }
}

# GATEWAY ENDPOINT
resource "aws_vpc_endpoint" "gateway_vpc_endpoint_s3" {
  vpc_id            = var.vpc_id
  service_name      = join(".", ["com", "amazonaws", var.region, "s3"])
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.gateway_endpoint_rt_id]

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoint",
      "s3"
    ])
  }
}

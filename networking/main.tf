# VPC - IGW
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = join("-", [var.tag_prefix, "vpc"])
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = join("-", [var.tag_prefix, "igw"])
  }
}

# SUBNETS
resource "aws_subnet" "public_subnet_az_1" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[0], "cidr_block")
  availability_zone       = lookup(var.subnet_data[0], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[0], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "public",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[0], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[0], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "public_subnet_az_2" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[1], "cidr_block")
  availability_zone       = lookup(var.subnet_data[1], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[1], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "public",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[1], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[1], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "public_subnet_az_3" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[2], "cidr_block")
  availability_zone       = lookup(var.subnet_data[2], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[2], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "public",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[2], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[2], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "private_subnet_az_1" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[3], "cidr_block")
  availability_zone       = lookup(var.subnet_data[3], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[3], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "private",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[3], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[3], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "private_subnet_az_2" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[4], "cidr_block")
  availability_zone       = lookup(var.subnet_data[4], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[4], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "private",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[4], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[4], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "private_subnet_az_3" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[5], "cidr_block")
  availability_zone       = lookup(var.subnet_data[5], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[5], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "private",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[5], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[5], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "fargate_subnet_az_1" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[6], "cidr_block")
  availability_zone       = lookup(var.subnet_data[6], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[6], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "fargate",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[6], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[6], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "fargate_subnet_az_2" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[7], "cidr_block")
  availability_zone       = lookup(var.subnet_data[7], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[7], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "fargate",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[7], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[7], "public") == true ? "public" : "private"
  }
}

resource "aws_subnet" "fargate_subnet_az_3" {
  vpc_id = aws_vpc.vpc.id

  cidr_block              = lookup(var.subnet_data[8], "cidr_block")
  availability_zone       = lookup(var.subnet_data[8], "availability_zone")
  map_public_ip_on_launch = lookup(var.subnet_data[8], "public")

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "fargate",
      "subnet",
      "az",
      substr(lookup(var.subnet_data[8], "availability_zone"), -1, -1)
    ])
    "Type" = lookup(var.subnet_data[8], "public") == true ? "public" : "private"
  }
}

# ROUTING
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = join("-", [var.tag_prefix, "public", "rt"])
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = join("-", [var.tag_prefix, "private", "rt"])
  }
}

resource "aws_route_table_association" "public_az_1_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet_az_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_az_2_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet_az_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_az_3_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet_az_3.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_az_1_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet_az_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_az_2_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet_az_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_az_3_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet_az_3.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "fargate_az_1_rt_assoc" {
  subnet_id      = aws_subnet.fargate_subnet_az_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "fargate_az_2_rt_assoc" {
  subnet_id      = aws_subnet.fargate_subnet_az_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "fargate_az_3_rt_assoc" {
  subnet_id      = aws_subnet.fargate_subnet_az_3.id
  route_table_id = aws_route_table.private_rt.id
}

# SECURITY GROUPS
resource "aws_security_group" "server_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "server",
    "security",
    "group"
  ])
  description = "Security group for Confluence server instances."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "server",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "server_sg_ingress_ssh_myip" {
  security_group_id = aws_security_group.server_security_group.id
  description       = "Allows inbound SSH traffic on port 22 from a given source IP address (MyIp)."
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_ip]
}

resource "aws_security_group_rule" "server_sg_ingress_ssh_vpc" {
  security_group_id = aws_security_group.server_security_group.id
  description       = "Allows inbound SSH traffic on port 22 from internal VPC network."
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group_rule" "server_sg_ingress_8090" {
  security_group_id = aws_security_group.server_security_group.id
  description       = "Allows inbound traffic on port 8090 for Confluence from anywhere."
  type              = "ingress"
  from_port         = 8090
  to_port           = 8090
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "server_sg_ingress_2049" {
  security_group_id = aws_security_group.server_security_group.id
  description       = "Allows inbound traffic on port 2049 from VPC."
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group_rule" "server_sg_egress" {
  security_group_id = aws_security_group.server_security_group.id
  description       = "Allows all outbound traffic."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "database_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "db",
    "security",
    "group"
  ])
  description = "Security group for PostgreSQL RDS database instances."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "db",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "database_sg_ingress_5432_provisioner" {
  security_group_id        = aws_security_group.database_security_group.id
  description              = "Allows inbound traffic on port 5432 for from provisioner instance security group."
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.provisioner_instance_security_group.id
}

resource "aws_security_group_rule" "database_sg_ingress_5432_server" {
  security_group_id        = aws_security_group.database_security_group.id
  description              = "Allows inbound traffic on port 5432 for from Confluence servers security group."
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.server_security_group.id
}

resource "aws_security_group_rule" "database_sg_egress" {
  security_group_id = aws_security_group.database_security_group.id
  description       = "Allows all outbound traffic."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "lb",
    "security",
    "group"
  ])
  description = "Security group for the load balancer."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "lb",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "load_balancer_sg_ingress_http" {
  security_group_id = aws_security_group.load_balancer_security_group.id
  description       = "Allows inbound traffic on port 80 from anywhere."
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "load_balancer_sg_egress" {
  security_group_id        = aws_security_group.load_balancer_security_group.id
  description              = "Allows outbound traffic to Confluence servers."
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.server_security_group.id
}

resource "aws_security_group" "efs_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "efs",
    "security",
    "group"
  ])
  description = "Security group for the Elastic FileSystem."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "efs",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "efs_sg_ingress_2049" {
  security_group_id        = aws_security_group.efs_security_group.id
  description              = "Allows inbound traffic on port 2049 from Confluence Fargate server security group."
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.server_security_group.id
}

resource "aws_security_group_rule" "efs_sg_egress" {
  security_group_id = aws_security_group.efs_security_group.id
  description       = "Allows outbound traffic to VPC cidr."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group" "vpc_endpoint_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "vpc",
    "endpoint",
    "security",
    "group"
  ])
  description = "Security group for the VPC endpoints."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "vpc",
      "endpoints",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "vpc_endpoint_sg_ingress_443" {
  security_group_id = aws_security_group.vpc_endpoint_security_group.id
  description       = "Allows inbound traffic on port 443 from VPC."
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group" "provisioner_instance_security_group" {
  vpc_id = aws_vpc.vpc.id
  name = join("-", [
    var.tag_prefix,
    "provisioner",
    "instance",
    "security",
    "group"
  ])
  description = "Security group for the provisioner EC2 instance."

  tags = {
    "Name" = join("-", [
      var.tag_prefix,
      "provisioner",
      "instance",
      "security",
      "group"
    ])
  }
}

resource "aws_security_group_rule" "provisioner_instance_sg_ingress_ssh" {
  security_group_id = aws_security_group.provisioner_instance_security_group.id
  description       = "Allows inbound SSH traffic on port 22 from a dedicated IP address."
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_ip]
}

resource "aws_security_group_rule" "provisioner_instance_sg_ingress_HTTP" {
  security_group_id = aws_security_group.provisioner_instance_security_group.id
  description       = "Allows inbound HTTP traffic on port 80 from anywhere."
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "provisioner_instance_sg_egress" {
  security_group_id = aws_security_group.provisioner_instance_security_group.id
  description       = "Allows outbound traffic to anywhere."
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

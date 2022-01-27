output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az_1.id
}
output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az_2.id
}
output "public_subnet_az3_id" {
  value = aws_subnet.public_subnet_az_3.id
}
output "database_subnet_az1_id" {
  value = aws_subnet.database_subnet_az_1.id
}
output "database_subnet_az2_id" {
  value = aws_subnet.database_subnet_az_2.id
}
output "database_subnet_az3_id" {
  value = aws_subnet.database_subnet_az_3.id
}
output "fargate_subnet_az1_id" {
  value = aws_subnet.fargate_subnet_az_1.id
}
output "fargate_subnet_az2_id" {
  value = aws_subnet.fargate_subnet_az_2.id
}
output "fargate_subnet_az3_id" {
  value = aws_subnet.fargate_subnet_az_3.id
}
output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}
output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}
output "server_sg_id" {
  value = aws_security_group.server_security_group.id
}
output "database_sg_id" {
  value = aws_security_group.database_security_group.id
}
output "load_balancer_sg_id" {
  value = aws_security_group.load_balancer_security_group.id
}
output "efs_sg_id" {
  value = aws_security_group.efs_security_group.id
}
output "vpc_endpoint_sg_id" {
  value = aws_security_group.vpc_endpoint_security_group.id
}
output "provisioner_instance_sg_id" {
  value = aws_security_group.provisioner_instance_security_group.id
}

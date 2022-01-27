output "load_balancer_arn" {
  value = aws_lb.load_balancer.id
}
output "load_balancer_dns_name" {
  value = aws_lb.load_balancer.dns_name
}
output "target_group_confluence_arn" {
  value = aws_lb_target_group.target_group_confluence.arn
}
output "target_group_confluence_name" {
  value = aws_lb_target_group.target_group_confluence.name
}
output "target_group_synchrony_arn" {
  value = aws_lb_target_group.target_group_synchrony.arn
}
output "target_group_synchrony_name" {
  value = aws_lb_target_group.target_group_synchrony.name
}

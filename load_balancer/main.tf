resource "aws_lb_target_group" "target_group" {
  name                          = var.target_group_name
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "ip"
  port                          = var.confluence_port
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "tg",
      var.target_group_name
    ])
  }
}

resource "aws_lb" "load_balancer" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "lb",
      var.load_balancer_name
    ])
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.load_balancer_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

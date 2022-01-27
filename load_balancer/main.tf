resource "aws_lb_target_group" "target_group_confluence" {
  name                          = join("-", [var.tag_prefix, "worker", "tg"])
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "ip"
  port                          = 8090
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  health_check {
    enabled = true
    path = "/status"
    matcher = "200"
  }
  stickiness {
    enabled = true
    type = "lb_cookie"
    cookie_duration = 86400
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "worker",
      "tg"
    ])
  }
}

resource "aws_lb_target_group" "target_group_synchrony" {
  name                          = join("-", [var.tag_prefix, "synchrony", "tg"])
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "ip"
  port                          = 8091
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  health_check {
    enabled = true
    path = "/synchrony/heartbeat"
    matcher = "200"
  }
  stickiness {
    enabled = false
    type = "lb_cookie"
  }

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "synchrony",
      "tg"
    ])
  }
}

resource "aws_lb" "load_balancer" {
  name               = join("-", [var.tag_prefix, "lb"])
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = join("-", [
      var.tag_prefix,
      "lb"
    ])
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_confluence.arn
  }
}

resource "aws_lb_listener_rule" "synchrony" {
  listener_arn = aws_lb_listener.listener.arn
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group_synchrony.arn
  }
  condition {
    path_pattern {
      values = [ "/synchrony/*" ]
    }
  }
}

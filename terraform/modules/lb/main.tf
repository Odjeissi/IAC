# AWS LB

resource "aws_lb" "lb_main" {
  name               = "${var.env}-lb-main"
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags = {
    Name        = "${var.env}-lb-main"
    Environment = var.env
  }
}


# AWS LB Group

resource "aws_lb_target_group" "lb_tg" {
  name        = "${var.env}-lb-tg"
  target_type = var.target_type
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.env}-lb-tg"
    Environment = var.env
  }
}

# AWS LB Listeners

resource "aws_lb_listener" "lb_http_listener" {
  load_balancer_arn = aws_lb.lb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name        = "${var.env}-lb-http-listener"
    Environment = var.env
  }
}

resource "aws_lb_listener" "lb_https_listener" {
  load_balancer_arn = aws_lb.lb_main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate_Arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }

  tags = {
    Name        = "${var.env}-lb-https-listener"
    Environment = var.env
  }
}

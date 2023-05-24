# LbTargetGroup for api
resource "aws_lb_target_group" "api_blue" {
  name        = "${var.api_app_name}-blue-tg"
  port        = var.api_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/"
    port                = var.api_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }

  tags = {
    Name = "${var.app_name}-${var.api_app_name}-blue-tg"
  }
}

resource "aws_lb_target_group" "api_green" {
  name        = "${var.api_app_name}-green-tg"
  port        = var.api_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/"
    port                = var.api_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }

  tags = {
    Name = "${var.app_name}-${var.api_app_name}-green-tg"
  }
}

# LbTargetGroup for web
resource "aws_lb_target_group" "web_blue" {
  name        = "${var.web_app_name}-blue-tg"
  port        = var.web_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/index.html"
    port                = var.web_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }

  tags = {
    Name = "${var.app_name}-${var.web_app_name}-blue-tg"
  }
}

resource "aws_lb_target_group" "web_green" {
  name        = "${var.web_app_name}-green-tg"
  port        = var.web_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/index.html"
    port                = var.web_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }

  tags = {
    Name = "${var.app_name}-${var.web_app_name}-green-tg"
  }
}

# LbListenerRule for api
resource "aws_lb_listener_rule" "api-blue" {
  listener_arn = var.http_arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = var.api_blue_arn
  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

# LbListenerRule for web
resource "aws_lb_listener_rule" "web-blue" {
  listener_arn = var.http_arn
  priority     = 3
  action {
    type             = "forward"
    target_group_arn = var.web_blue_arn
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

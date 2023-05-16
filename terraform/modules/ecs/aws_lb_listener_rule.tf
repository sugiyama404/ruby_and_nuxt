# LbListenerRule for api
resource "aws_lb_listener_rule" "api-ecs" {
  listener_arn = var.http_arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = var.api_alb_target_group_arn
  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

# LbListenerRule for web
resource "aws_lb_listener_rule" "web-ecs" {
  listener_arn = var.http_arn
  priority     = 2
  action {
    type             = "forward"
    target_group_arn = var.web_alb_target_group_arn
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

output "api_alb_target_group_arn" {
  value = aws_lb_target_group.api_alb_target_group.arn
}

output "web_alb_target_group_arn" {
  value = aws_lb_target_group.web_alb_target_group.arn
}

output "http_arn" {
  value = aws_lb_listener.http.arn
}

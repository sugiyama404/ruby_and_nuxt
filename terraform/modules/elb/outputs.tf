output "api_alb_target_group_arn" {
  value = aws_lb_target_group.api_alb_target_group.arn
}

output "web_alb_target_group_arn" {
  value = aws_lb_target_group.web_alb_target_group.arn
}

output "http_arn" {
  value = aws_lb_listener.http.arn
}
#output "lb_listener_rule_api" {
#  value = aws_lb_listener_rule.api-ecs
#}

#output "lb_listener_rule_web" {
#  value = aws_lb_listener_rule.web-ecs
#}

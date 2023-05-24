output "api_blue_arn" {
  value = aws_lb_target_group.api_blue.arn
}

output "web_blue_arn" {
  value = aws_lb_target_group.web_blue.arn
}

output "api_green_arn" {
  value = aws_lb_target_group.api_green.arn
}

output "web_green_arn" {
  value = aws_lb_target_group.web_green.arn
}


output "http_arn" {
  value = aws_lb_listener.http.arn
}

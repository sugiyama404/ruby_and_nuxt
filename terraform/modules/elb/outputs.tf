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

output "api_blue_name" {
  value = aws_lb_target_group.api_blue.name
}

output "web_blue_name" {
  value = aws_lb_target_group.web_blue.name
}

output "api_green_name" {
  value = aws_lb_target_group.api_green.name
}

output "web_green_name" {
  value = aws_lb_target_group.web_green.name
}

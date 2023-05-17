output "db_endpoint" {
  value = aws_db_instance.db-setting.endpoint
}

output "db_instance_name" {
  value = aws_db_instance.db-setting.name
}

output "db_name" {
  value = aws_db_instance.db-setting.db_name
}

output "db_username" {
  value = aws_db_instance.db-setting.username
}

output "db_password" {
  value = aws_db_instance.db-setting.password
}


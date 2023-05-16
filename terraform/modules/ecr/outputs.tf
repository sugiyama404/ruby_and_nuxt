output "api_repository_url" {
  description = "The URL of the api image repository."
  value       = aws_ecr_repository.api_repository.repository_url
}

output "web_repository_url" {
  description = "The URL of the web image repository."
  value       = aws_ecr_repository.web_repository.repository_url
}

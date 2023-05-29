output "cluster-name" {
  value = "aws_ecs_cluster.cluster.name"
}

output "api-service-name" {
  value = "aws_ecs_service.api-service.name"
}

output "web-service-name" {
  value = "aws_ecs_service.web-service.name"
}

output "api-definition-arn" {
  value = "aws_ecs_task_definition.api-definition.arn"
}

output "web-definition-arn" {
  value = "aws_ecs_task_definition.web-definition.arn"
}

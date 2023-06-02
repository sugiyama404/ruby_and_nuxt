resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.app_name}-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "capacity_provider" {
  cluster_name       = "${var.app_name}-cluster"
  capacity_providers = ["FARGATE"]

  # default_capacity_provider_strategy {
  #   base              = 1
  #   weight            = 100
  #   capacity_provider = "FARGATE"
  # }
}

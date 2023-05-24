# EcsService for Fargate api
resource "aws_ecs_service" "api-service" {
  name            = "${var.api_app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  depends_on      = [aws_lb_listener_rule.api-blue, aws_lb_listener_rule.api-green]
  task_definition = aws_ecs_task_definition.api-definition.arn
  desired_count   = 1
  # ecs exec
  enable_execute_command = true

  network_configuration {
    subnets          = ["${var.subnet_p1a_id}"]
    security_groups  = ["${var.apserver_sg_id}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.api_blue_arn
    container_name   = var.api_app_name
    container_port   = var.api_ports[0].internal
  }

}

# EcsService for Fargate web
resource "aws_ecs_service" "web-service" {
  name    = "${var.web_app_name}-service"
  cluster = aws_ecs_cluster.cluster.id
  depends_on = [aws_lb_listener_rule.web-blue, aws_lb_listener_rule.api-blue,
  aws_lb_listener_rule.web-green, aws_lb_listener_rule.api-green]
  task_definition = aws_ecs_task_definition.web-definition.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = var.web_blue_arn
    container_name   = var.web_app_name
    container_port   = var.web_ports[0].internal
  }

  network_configuration {
    subnets          = ["${var.subnet_p1c_id}"]
    security_groups  = ["${var.webserver_sg_id}"]
    assign_public_ip = true
  }

}

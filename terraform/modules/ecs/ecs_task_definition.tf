# TaskDefinition for Fargate api
resource "aws_ecs_task_definition" "api-definition" {
  family                   = "${var.api_app_name}-definition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.ecs_main_role
  task_role_arn            = var.ecs_main_role
  network_mode             = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "${var.api_app_name}"
      image     = "${var.api_repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          hostPort      = var.api_ports[0].internal
          containerPort = var.api_ports[0].external
        }
      ]
      environment = [
        {
          name  = "HOST"
          value = split(":", "${var.db_endpoint}")[0]
        },
        {
          name  = "DBNAME"
          value = "${var.db_name}"
        },
        {
          name  = "USERNAME"
          value = "${var.db_username}"
        },
        {
          name  = "PASSWORD"
          value = "${var.db_password}"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "${var.api_app_name}"
          awslogs-create-group  = "true"
          awslogs-group         = "/fargate/${var.app_name}/dev/${var.api_app_name}"
        }
      }
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = {
    Name = "${var.app_name}-${var.api_app_name}-template"
  }
}

# TaskDefinition for Fargate web
resource "aws_ecs_task_definition" "web-definition" {
  family                   = "${var.web_app_name}-definition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.ecs_main_role
  task_role_arn            = var.ecs_main_role
  network_mode             = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "${var.web_app_name}"
      image     = "${var.web_repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.web_ports[0].internal
          hostPort      = var.web_ports[0].external
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "${var.web_app_name}"
          awslogs-create-group  = "true"
          awslogs-group         = "/fargate/${var.app_name}/dev/${var.web_app_name}"
        }
      }
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  tags = {
    Name = "${var.app_name}-${var.web_app_name}-template"
  }
}

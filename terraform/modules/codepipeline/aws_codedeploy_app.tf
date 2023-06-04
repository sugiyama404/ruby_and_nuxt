resource "aws_codedeploy_app" "main" {
  compute_platform = "ECS"
  name             = var.app_name
}

resource "aws_codedeploy_deployment_group" "web" {
  app_name               = aws_codedeploy_app.main.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.web_app_name
  service_role_arn       = aws_iam_role.codedeploy-role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = "todolist-cluster"
    service_name = "webserver-service"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.http_arn]
      }

      target_group {
        name = var.web_blue_name
      }

      target_group {
        name = var.web_green_name
      }
    }
  }
}


resource "aws_codedeploy_deployment_group" "api" {
  app_name               = aws_codedeploy_app.main.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.api_app_name
  service_role_arn       = aws_iam_role.codedeploy-role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = "todolist-cluster"
    service_name = "apiserver-service"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.http_arn]
      }

      target_group {
        name = var.api_blue_name
      }

      target_group {
        name = var.api_green_name
      }
    }
  }
}

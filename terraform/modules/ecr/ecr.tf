# EcrRepository for api
resource "aws_ecr_repository" "api_repository" {
  name         = var.api_app_name
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.app_name}-${var.api_app_name}-repository"
  }
}

# EcrRepository for web
resource "aws_ecr_repository" "web_repository" {
  name         = var.web_app_name
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.app_name}-${var.web_app_name}-repository"
  }
}


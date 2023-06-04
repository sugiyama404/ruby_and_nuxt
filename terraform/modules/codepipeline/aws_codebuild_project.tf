resource "aws_codebuild_project" "web" {
  name         = "${var.app_name}-web-codebuild"
  description  = "codebuild_project for web ${var.app_name}"
  service_role = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "terraform/template/web_buildspec.yml"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true


    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.self.account_id
    }
    environment_variable {
      name  = "ECR_WEB_REPOSITORY"
      value = var.web_app_name
    }
    environment_variable {
      name  = "ECS_WEB_TASK_DEFINITION_ARN"
      value = "${var.web_app_name}-definition"
    }
  }
}

resource "aws_codebuild_project" "api" {
  name         = "${var.app_name}-api-codebuild"
  description  = "codebuild_project for api ${var.app_name}"
  service_role = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "terraform/template/api_buildspec.yml"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.self.account_id
    }
    environment_variable {
      name  = "ECR_API_REPOSITORY"
      value = var.api_app_name
    }
    environment_variable {
      name  = "ECS_API_TASK_DEFINITION_ARN"
      value = "${var.api_app_name}-definition"
    }
  }
}

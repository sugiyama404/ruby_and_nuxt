resource "aws_codebuild_project" "main" {
  name         = "${var.app_name}-codebuild"
  description  = "codebuild_project for ${var.app_name}"
  service_role = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "terraform/template/buildspec.yml"
  }

  secondary_artifacts {
    type                = "S3"
    artifact_identifier = "BuildArtifact1"
    name                = "BuildArtifact1"
    location            = aws_s3_bucket.codepipeline_bucket.id
    path                = "${aws_s3_bucket.codepipeline_bucket.id}/BuildArtifact1"
    packaging           = "ZIP"
    namespace_type      = "BUILD_ID"
  }

  secondary_artifacts {
    type                = "S3"
    artifact_identifier = "BuildArtifact2"
    name                = "BuildArtifact2"
    location            = aws_s3_bucket.codepipeline_bucket.id
    path                = "${aws_s3_bucket.codepipeline_bucket.id}/BuildArtifact2"
    packaging           = "ZIP"
    namespace_type      = "BUILD_ID"
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
      value = var.web-definition-arn
    }
    environment_variable {
      name  = "ECR_API_REPOSITORY"
      value = var.api_app_name
    }
    environment_variable {
      name  = "ECS_API_TASK_DEFINITION_ARN"
      value = var.api-definition-arn
    }
  }
}

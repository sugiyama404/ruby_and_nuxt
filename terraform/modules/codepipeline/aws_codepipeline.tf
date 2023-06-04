resource "aws_codepipeline" "codepipeline" {
  name     = "${var.app_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    # S3 (アーティファクト格納用)
    # CodePileline では次のステージにアーティファクトを引き渡す時、S3 バケットを経由させます。
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      output_artifacts = ["SourceArtifact"]
      version          = "1"

      configuration = {
        RepositoryName       = aws_codecommit_repository.codecommit_repository.repository_name
        BranchName           = "main"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    # webserver
    action {
      name             = "WEB_Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact1"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.web.name
      }
    }

    # apisever
    action {
      name             = "API_Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact2"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.api.name
      }
    }
  }

  stage {
    name = "Deploy"

    # webserver
    action {
      name            = "WEB_Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact1"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name
        DeploymentGroupName            = aws_codedeploy_deployment_group.web.deployment_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifact1"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact1"
        AppSpecTemplatePath            = "appspec.yml"
        Image1ArtifactName             = "BuildArtifact1"
        Image1ContainerName            = "IMAGE1_NAME"
      }
    }

    # apserver
    action {
      name            = "API_Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["BuildArtifact2"]
      version         = "1"

      configuration = {
        ApplicationName                = var.app_name
        DeploymentGroupName            = aws_codedeploy_deployment_group.api.deployment_group_name
        TaskDefinitionTemplateArtifact = "BuildArtifact2"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "BuildArtifact2"
        AppSpecTemplatePath            = "appspec.yml"
        Image1ArtifactName             = "BuildArtifact2"
        Image1ContainerName            = "IMAGE1_NAME"
      }
    }
  }
}



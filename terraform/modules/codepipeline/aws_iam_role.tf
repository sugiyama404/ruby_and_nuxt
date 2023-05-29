resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"
  assume_role_policy = jsonencode({

    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.app_name}-codepipeline-role"
  }
}

resource "aws_iam_role" "codebuild-role" {
  name = "${var.app_name}-codebuild-role"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.app_name}-codebuild-role"
  }
}

resource "aws_iam_role" "codedeploy-role" {
  name = "${var.app_name}-codedeploy-role"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.app_name}-codedeploy-role"
  }
}

# cloud watch
resource "aws_iam_role" "cwe_role" {
  name = "${var.app_name}-cwe-role"
  assume_role_policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "${var.app_name}-cwe-role"
  }
}

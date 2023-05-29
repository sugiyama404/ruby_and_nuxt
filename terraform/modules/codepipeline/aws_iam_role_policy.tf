resource "aws_iam_role_policy" "codepipeline-policy" {
  name   = "codepipeline-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline-policy.json
}

data "aws_iam_policy_document" "codepipeline-policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "ecr:DescribeImages",
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:RegisterApplicationRevision",
      "codedeploy:GetDeploymentConfig",
      "ecs:RegisterTaskDefinition"
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:UploadArchive",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:CancelUploadArchive"
    ]
    resources = ["${aws_codecommit_repository.codecommit_repository.arn}"]
  }
  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codebuild-policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild-role.name
  policy = data.aws_iam_policy_document.codebuild-policy.json
}

data "aws_iam_policy_document" "codebuild-policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*",
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["ecs:DescribeTaskDefinition"]
    resources = ["*"]
  }
}

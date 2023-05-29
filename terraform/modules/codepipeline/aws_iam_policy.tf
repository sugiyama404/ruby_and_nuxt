# cloud watch
resource "aws_iam_policy" "cwe_policy" {
  name = "${var.app_name}-cwe-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "codepipeline:StartPipelineExecution",
        ]
        Resource = [
          "${aws_codepipeline.codepipeline.arn}",
        ]
        Effect = "Allow"
      },
    ]
  })
}

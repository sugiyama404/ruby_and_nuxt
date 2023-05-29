resource "aws_cloudwatch_event_target" "codepipeline" {
  rule      = aws_cloudwatch_event_rule.image_push.name
  target_id = "${var.app_name}-Image-Push-Codepipeline"
  arn       = aws_codepipeline.codepipeline.arn
  role_arn  = aws_iam_role.cwe_role.arn
}

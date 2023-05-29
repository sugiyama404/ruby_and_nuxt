resource "aws_cloudwatch_event_rule" "image_push" {
  name     = "codecommit_push"
  role_arn = aws_iam_role.cwe_role.arn

  event_pattern = jsonencode({
    source      = ["aws.codecommit"]
    detail-type = ["CodeCommit Repository State Change"]
    resources   = ["${aws_codecommit_repository.codecommit_repository.arn}"]

    detail = {
      event         = ["referenceCreated", "referenceUpdated"]
      referenceType = ["branch"]
      referenceName = ["main"]
    }
  })
}

locals {
  alb_root_account_id = "582318560864"
  # ロードバランサーのリージョンに対応するAWSアカウントID
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html#attach-bucket-policy
}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.alb_access_log.id
  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["${local.alb_root_account_id}"]
    }
    actions = ["*"]
    resources = [
      aws_s3_bucket.alb_access_log.arn,
      "${aws_s3_bucket.alb_access_log.arn}/*",
    ]
  }
}

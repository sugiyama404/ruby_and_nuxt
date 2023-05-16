resource "aws_s3_bucket_acl" "alb_access_logs_acl" {
  bucket = aws_s3_bucket.alb_access_log.id
  acl    = "private"
}

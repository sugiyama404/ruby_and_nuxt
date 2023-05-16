resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.alb_access_log.id
  versioning_configuration {
    status = "Enabled"
  }
}

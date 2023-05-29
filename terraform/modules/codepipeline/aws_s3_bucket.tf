resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket        = "codepipeline-bucket-${random_string.s3_unique_key.result}"
  force_destroy = true
}

resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

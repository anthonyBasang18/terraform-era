resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "${var.name}-cloudtrail-logs"
  acl    = "private"

  lifecycle_rule {
    id      = "log-retention"
    enabled = true

    expiration {
      days = var.s3_retention_days
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "${var.name}-cloudtrail-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "cloudtrail_logs_block" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

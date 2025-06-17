resource "aws_s3_bucket" "config_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "config-retention"
    enabled = true

    expiration {
      days = 3650  # 10 years
    }
  }

  tags = {
    Name = "${var.name}-config-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "config_bucket_block" {
  bucket = aws_s3_bucket.config_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

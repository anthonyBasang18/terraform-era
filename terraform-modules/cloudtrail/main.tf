resource "aws_cloudtrail" "this" {
  name                          = var.name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  enable_logging                = true
  kms_key_id                    = var.kms_key_id != "" ? var.kms_key_id : null

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]  # To log all S3 data events; narrow if needed
    }

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]  # To log all Lambda invocations; narrow if needed
    }
  }

  tags = {
    Name = var.name
  }

  depends_on = [
    aws_s3_bucket.cloudtrail_logs,
    aws_cloudwatch_log_group.cloudtrail,
    aws_iam_role.cloudtrail
  ]
}

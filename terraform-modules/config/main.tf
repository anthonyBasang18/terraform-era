resource "aws_config_configuration_recorder" "this" {
  name     = "default"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported                         = var.recording_all_supported
    include_global_resource_types         = true
    include_aws_service_event_resources   = true
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket
  sns_topic_arn  = var.sns_topic_arn != "" ? var.sns_topic_arn : null

  depends_on = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  name       = aws_config_configuration_recorder.this.name
  is_enabled = true
}

output "config_recorder_name" {
  description = "Name of the AWS Config recorder"
  value       = aws_config_configuration_recorder.this.name
}

output "config_bucket_id" {
  description = "S3 bucket used by AWS Config"
  value       = aws_s3_bucket.config_bucket.id
}

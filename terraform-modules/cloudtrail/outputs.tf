output "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  value       = aws_cloudtrail.this.name
}

output "cloudtrail_bucket_name" {
  description = "S3 bucket storing CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_log_group_name" {
  description = "CloudWatch Log Group for CloudTrail"
  value       = aws_cloudwatch_log_group.cloudtrail.name
}

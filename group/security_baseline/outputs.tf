output "cloudtrail_name" {
  description = "Name of the CloudTrail that was created"
  value       = module.cloudtrail.cloudtrail_name
}

output "cloudtrail_log_group" {
  description = "Log Group name for CloudTrail"
  value       = module.cloudtrail.cloudtrail_log_group
}

output "config_recorder_name" {
  description = "Name of the AWS Config recorder"
  value       = module.config.config_recorder_name
}

output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector"
  value       = module.guardduty.detector_id
}

output "securityhub_status" {
  description = "Status of Security Hub (enabled/disabled)"
  value       = module.securityhub.status
}

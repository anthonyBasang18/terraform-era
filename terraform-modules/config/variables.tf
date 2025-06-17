variable "name" {
  description = "Prefix for AWS Config resources"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name where AWS Config will deliver snapshots and configuration history"
  type        = string
}

variable "sns_topic_arn" {
  description = "Optional SNS topic to send AWS Config notifications"
  type        = string
  default     = ""
}

variable "recording_all_supported" {
  description = "Whether to record all supported resource types (true/false)"
  type        = bool
  default     = true
}

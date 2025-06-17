variable "name" {
  description = "Prefix name for CloudTrail and its related resources"
  type        = string
}

variable "s3_retention_days" {
  description = "Number of days to retain logs in S3 (lifecycle expiration)"
  type        = number
  default     = 1825  # 5 years
}

variable "cw_retention_days" {
  description = "Retention period (in days) for CloudWatch Logs"
  type        = number
  default     = 365
}

variable "kms_key_id" {
  description = "Optional KMS Key ARN/ID to encrypt CloudTrail logs in S3"
  type        = string
  default     = ""
}

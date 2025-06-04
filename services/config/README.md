# AWS Config Module

This Terraform module provisions AWS Config components:

- S3 bucket for Config snapshots and configuration history (with versioning, lifecycle, and public‐access blocking)
- IAM role and policy for AWS Config
- Configuration Recorder (records supported resource types, optionally SNS notifications)
- Delivery Channel to send snapshots/history to S3 (and SNS, if provided)
- Starts recording automatically

---

## 📂 Module Structure

services/config/
├── main.tf # aws_config_configuration_recorder, delivery channel, recorder status
├── s3_bucket.tf # aws_s3_bucket, public‐access block, versioning, lifecycle
├── iam_role.tf # aws_iam_role + policy attachment for AWS Config
├── variables.tf # module inputs
└── outputs.tf # module outputs

---

## ⚙️ Usage

```hcl
module "config" {
  source            = "../../services/config"
  name              = "customer-xyz-security"
  s3_bucket_name    = "customer-xyz-config-bucket"
  sns_topic_arn     = ""            # (optional) SNS topic for notifications
  recording_all_supported = true    # record all supported resource types
}

# CloudTrail Module

This Terraform module provisions a multi-region AWS CloudTrail trail with:

- S3 bucket for log storage (with versioning, lifecycle, and public‐access blocking)
- IAM role and policy that allow CloudTrail to write to S3 and CloudWatch Logs
- CloudWatch Log Group for CloudTrail events
- Data event logging for S3 objects and Lambda functions
- (Optional) KMS encryption for log files

---

## 📂 Module Structure

services/cloudtrail/
├── main.tf # aws_cloudtrail resource and event selectors
├── s3.tf # aws_s3_bucket, public‐access block, lifecycle, versioning
├── cloudwatch.tf # aws_cloudwatch_log_group
├── iam_role.tf # aws_iam_role + policy for CloudTrail
├── variables.tf # module inputs
└── outputs.tf # module outputs

---

## ⚙️ Usage

```hcl
module "cloudtrail" {
  source = "../../services/cloudtrail"

  name              = "customer-xyz-security"
  s3_retention_days = 1825            # 5 years retention in S3
  cw_retention_days = 365             # 1 year retention in CloudWatch Logs
  kms_key_id        = ""              # optional: pass KMS Key ARN for S3 encryption
}

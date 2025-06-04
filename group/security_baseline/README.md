# Security Baseline Group Module

This “group” module bundles together core AWS security services:
- **CloudTrail** (multi-region, log file validation, S3 + CloudWatch)
- **AWS Config** (recorder + delivery channel)
- **GuardDuty** (detector)
- **Security Hub** (enrollment)

All resources are created with a common `name` prefix and optional `tags`.

---

## Usage

In your environment folder (e.g. `environments/project/security-test/`):

```hcl
module "security_baseline" {
  source = "../../../group/security_baseline"

  name = "customer-xyz-security"
  tags = {
    Environment = "dev"
    Team        = "CloudFoundation"
  }
}

# Security Hub Module

This Terraform module enables AWS Security Hub in the current AWS account:

- Calls `aws_securityhub_account` to turn on Security Hub
- (Optional dependencies can be added, e.g., if GuardDuty must be enabled first)

---

## 📂 Module Structure

services/securityhub/
├── main.tf # aws_securityhub_account
├── variables.tf # module inputs
└── outputs.tf # module outputs

yaml
Copy
Edit

---

## ⚙️ Usage

```hcl
module "securityhub" {
  source = "../../services/securityhub"
  name   = "customer-xyz-security"
  enable = true
}
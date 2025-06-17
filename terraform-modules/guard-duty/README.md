# GuardDuty Module

This Terraform module provisions an AWS GuardDuty detector:

- Enables GuardDuty in the current AWS account and region
- Optionally tags the detector

---

## 📂 Module Structure

services/guardduty/
├── main.tf # aws_guardduty_detector
├── variables.tf # module inputs
└── outputs.tf # module outputs

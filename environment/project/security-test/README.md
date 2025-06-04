# Security Baseline Group Module

This Terraform “group” module bundles together core AWS security services into a single, reusable deployment:

1. **CloudTrail**  
2. **AWS Config**  
3. **GuardDuty**  
4. **Security Hub**  

Each service lives under `services/<service_name>/`, and this module orchestrates them all with one Terraform apply.

---

## 📂 Module Structure

group/security_baseline/
├── main.tf # Calls each service module
├── variables.tf # High-level inputs (name, tags, etc.)
├── outputs.tf # Aggregated outputs from child modules
└── README.md # This file

markdown
Copy
Edit

- **`main.tf`**  
  Contains four `module` blocks to invoke:
  - `services/cloudtrail/`
  - `services/config/`
  - `services/guardduty/`
  - `services/securityhub/`

- **`variables.tf`**  
  Defines:
  - `name` (common naming prefix for all services)  
  - `tags` (map of tags applied to every resource)

- **`outputs.tf`**  
  Aggregates outputs from each service module, such as:
  - CloudTrail trail name  
  - AWS Config recorder name  
  - GuardDuty detector ID  
  - Security Hub status

---

## ⚙️ Usage

In your environment folder (for example, `environments/project/security-test/`), add a `module` block like this:

```hcl
module "security_baseline" {
  source = "../../../group/security_baseline"
  name   = var.name             # e.g. "customer-xyz-security"
  tags   = var.tags             # e.g. { Environment = "dev", Team = "CloudFoundation" }
}


Then run:

cd environments/project/security-test

terraform init
terraform plan -out=tfplan
terraform apply tfplan
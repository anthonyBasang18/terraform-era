# Networking Terraform Module

This module provisions a secure, flexible VPC environment including:

- Custom CIDR block for the VPC
- Public and private subnets (with naming, AZs, and CIDRs)
- Optional Internet Gateway (IGW)
- Optional NAT Gateway(s)
- Route tables for both public and private subnets
- Optional VPC Flow Logs to CloudWatch Logs

---

## 🚀 Usage

```hcl
module "networking" {
  source = "../../services/networking"

  name     = "dev"
  vpc_cidr = "10.0.0.0/16"

  create_internet_gateway = true
  create_nat_gateway      = true
  enable_flow_logs        = true
  flow_log_role_arn       = "arn:aws:iam::1234567890:role/flowlog-role"

  public_subnets = {
    pub1 = { cidr = "10.0.1.0/24", az = "ap-southeast-1a", name = "public-a" }
    pub2 = { cidr = "10.0.2.0/24", az = "ap-southeast-1b", name = "public-b" }
  }

  private_subnets = {
    priv1 = { cidr = "10.0.101.0/24", az = "ap-southeast-1a", name = "private-a" }
    priv2 = { cidr = "10.0.102.0/24", az = "ap-southeast-1b", name = "private-b" }
  }
}




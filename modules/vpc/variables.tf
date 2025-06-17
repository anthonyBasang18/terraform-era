variable "name" {
  description = "Base name to prefix all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "create_internet_gateway" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true
}

variable "create_nat_gateway" {
  description = "Whether to create NAT Gateway(s)"
  type        = bool
  default     = false
}

variable "nat_gateway_strategy" {
  description = "Strategy to use for NAT Gateway. Options: 'single', 'multi'. Required only if create_nat_gateway is true."
  type        = string
  default     = ""

  validation {
    condition     = var.nat_gateway_strategy == "" || contains(["single", "multi"], var.nat_gateway_strategy)
    error_message = "nat_gateway_strategy must be either '', 'single', or 'multi'."
  }
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch"
  type        = bool
  default     = false
}

variable "flow_log_role_arn" {
  description = "IAM Role ARN for publishing flow logs to CloudWatch"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "Map of public subnet definitions"
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  default = {}
}

variable "private_subnets" {
  description = "Map of private subnet definitions"
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  default = {}
}

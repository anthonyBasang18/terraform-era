variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "name" {
  description = "Prefix for all baseline resources"
  type        = string
}

variable "tags" {
  description = "Tags applied to every baseline resource"
  type        = map(string)
  default     = {}
}

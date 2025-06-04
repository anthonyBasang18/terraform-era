variable "name" {
  description = "Prefix for GuardDuty resources (used in tags)"
  type        = string
}

variable "enable" {
  description = "Whether to enable GuardDuty detector"
  type        = bool
  default     = true
}

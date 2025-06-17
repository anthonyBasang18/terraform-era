variable "name" {
  description = "Prefix for Security Hub resources (used in tags)"
  type        = string
}

variable "enable" {
  description = "Whether to enable Security Hub"
  type        = bool
  default     = true
}

variable "name" {
  description = "Common prefix for all baseline resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all baseline resources"
  type        = map(string)
  default     = {}
}

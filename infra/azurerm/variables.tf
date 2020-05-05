// Naming
variable "app_name" {
  type        = "string"
  description = "Location of the azure resource group."
  default     = "iphone-search"
}
// Resource information

variable "location" {
  type        = "string"
  description = "Location of the azure resource group."
  default     = "EastUS"
}

variable "dns_prefix" {
  type        = "string"
  description = "DNS Prefix"
  default     = "tfq"
}

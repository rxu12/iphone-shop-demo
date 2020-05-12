// Naming
variable "app_name" {
  type        = string
  description = "Location of the azure resource group."
  default     = "iphone-search"
}


variable "app_acr_name" {
  type        = string
  description = "name of the azure container registry."
  default     = "iphone-search"
}

// Resource information

variable "location" {
  type        = string
  description = "Location of the azure resource group."
  default     = "EastUS"
}

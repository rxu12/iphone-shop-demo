# The Azure Active Resource Manager Terraform provider
provider "azurerm" {
  version = "~> 2.9"
  features {}
}

variable "app_name" {
  type        = string
  description = "Location of the azure resource group."
  default     = "iphone-search"
}

variable "location" {
  type        = string
  description = "Location of the azure resource group."
  default     = "EastUS"
}

# The main resource group for this deployment
resource "azurerm_resource_group" "default" {
  name     = "${var.app_name}-rg"
  location = var.location
}

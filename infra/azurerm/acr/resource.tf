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

variable "app_acr_name" {
  type        = string
  description = "name of the azure container registry."
  default     = "iphone-search"
}

data "azurerm_resource_group" "default" {
  name = "${var.app_name}-rg"
}

resource "azurerm_container_registry" "default" {
  name                     = var.app_acr_name
  resource_group_name      = data.azurerm_resource_group.default.name
  location                 = data.azurerm_resource_group.default.location
  sku                      = "Standard"
  admin_enabled            = false
}
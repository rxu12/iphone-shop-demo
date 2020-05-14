# The Azure Active Resource Manager Terraform provider
provider "azurerm" {
  version = "~> 2.9"
  features {}
}

variable "app_acr_name" {
  type        = string
  description = "name of the azure container registry."
  default     = "iphone-search"
}

resource "azurerm_container_registry" "default" {
  name                     = var.app_acr_name
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  sku                      = "Standard"
  admin_enabled            = false
}
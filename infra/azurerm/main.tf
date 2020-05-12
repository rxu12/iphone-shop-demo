# The Azure Active Resource Manager Terraform provider
provider "azurerm" {
  version = "~> 2.9"
  features {}
}

# The Azure Active Directory Terraform provider
provider "azuread" {
  version = "~> 0.8"
}

provider "random" {
  version = "~> 2.2"
}

# Reference to the current subscription.  Used when creating role assignments
data "azurerm_subscription" "current" {}

# The main resource group for this deployment
resource "azurerm_resource_group" "default" {
  name     = "${var.app_name}-rg"
  location = var.location
}

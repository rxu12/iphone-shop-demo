# The Azure Active Resource Manager Terraform provider
provider "azurerm" {}

# The Azure Active Directory Terraform provider
provider "azuread" {}

# Reference to the current subscription.  Used when creating role assignments
data "azurerm_subscription" "current" {}

# The main resource group for this deployment
resource "azurerm_resource_group" "default" {
  name     = "${var.app_name}-rg"
  location = "${var.location}"
}

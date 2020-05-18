# provider "azurerm" {
#   version = "~> 2.9"
#   features {}
# }

# # The Azure Active Directory Terraform provider
# provider "azuread" {
#   version = "~> 0.8"
# }

# provider "random" {
#   version = "~> 2.2"
# }

# variable "app_name" {
#   type        = string
#   description = "Location of the azure resource group."
#   default     = "iphone-search"
# }

# variable "app_acr_name" {
#   type        = string
#   description = "name of the azure container registry."
#   default     = "iphone-search"
# }

# # Reference to the current subscription.  Used when creating role assignments
# data "azurerm_subscription" "current" {}

# data "azurerm_resource_group" "default" {
#   name = "${var.app_name}-rg"
# }

# data "azurerm_container_registry" "default" {
#   resource_group_name = "${var.app_name}-rg"
#   name = var.app_acr_name
# }

# resource "azuread_application" "default" {
#   name = "${var.app_name}-ad-app"
# }

# resource "azuread_service_principal" "default" {
#   application_id = azuread_application.default.application_id
# }

# resource "random_password" "password" {
#   length  = 32
#   special = true
# }

# resource "azuread_service_principal_password" "default" {
#   service_principal_id = azuread_service_principal.default.id
#   value                = random_password.password.result
#   end_date             = "2099-01-01T01:00:00Z"
# }

# resource "azurerm_role_assignment" "appsvc_acr" {
#   scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${data.azurerm_resource_group.default.name}/providers/Microsoft.ContainerRegistry/registries/${data.azurerm_container_registry.default.name}"
#   role_definition_name = "Reader"
#   principal_id         = azuread_service_principal.default.id
# }
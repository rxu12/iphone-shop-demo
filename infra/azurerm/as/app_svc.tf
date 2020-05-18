provider "azurerm" {
  version = "~> 2.9"
  features {}
}

provider "azuread" {
  version = "~> 0.8"
}

provider "random" {
  version = "~> 2.2"
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

variable "acr_link" {
  type        = string
  description = "acr link"
}

variable "docker_image_tag" {
  type        = string
  description = "version tag of the image"
  default     = "latest"
}

data "azurerm_resource_group" "default" {
  name = "${var.app_name}-rg"
}

data "azurerm_subscription" "current" {}

# Create SP to pull from ACR

resource "azuread_application" "default" {
  name = "${var.app_name}-ad-app"
}

resource "azuread_service_principal" "default" {
  application_id = azuread_application.default.application_id
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "default" {
  service_principal_id = azuread_service_principal.default.id
  value                = random_password.password.result
  end_date             = "2099-01-01T01:00:00Z"
}

resource "azurerm_role_assignment" "appsvc_acr" {
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${data.azurerm_resource_group.default.name}/providers/Microsoft.ContainerRegistry/registries/${var.app_acr_name}"
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.default.id
}

# Define app svc and plan

resource "azurerm_app_service_plan" "default" {
  name                = "${var.app_name}-asp"
  location            = data.azurerm_resource_group.default.location
  resource_group_name = data.azurerm_resource_group.default.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# This creates the service definition
resource "azurerm_app_service" "default" {
  name                = "${var.app_name}-app-service"
  location            = data.azurerm_resource_group.default.location
  resource_group_name = data.azurerm_resource_group.default.name
  app_service_plan_id = azurerm_app_service_plan.default.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|${var.acr_link}/${var.app_name}:${var.docker_image_tag}"
    always_on        = true
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    # app specific environment variables can be defined in this block as well
    WEBSITES_PORT                   = 9000
    DOCKER_REGISTRY_SERVER_URL      = "https://${var.acr_link}"
    DOCKER_REGISTRY_SERVER_USERNAME = azuread_application.default.application_id
    DOCKER_REGISTRY_SERVER_PASSWORD = azuread_service_principal_password.default.value
  }
}

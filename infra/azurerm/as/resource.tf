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
    linux_fx_version = "DOCKER|${var.app_acr_name}:${var.docker_image_tag}"
    always_on        = true
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_REGISTRY_SERVER_URL          = "https://${var.acr_link}"

    # app specific environment variables can be defined in this block as well
  }
}

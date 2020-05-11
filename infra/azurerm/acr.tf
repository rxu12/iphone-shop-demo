resource "azurerm_container_registry" "default" {
  name                     = "${replace(var.app_name, "-", "")}acr"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  sku                      = "Standard"
  admin_enabled            = false
}
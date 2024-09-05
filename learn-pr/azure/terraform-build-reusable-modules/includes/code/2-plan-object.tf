resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = var.app_service_plan.os
  sku_name            = var.app_service_plan.sku
}
terraform {
  required_version = "> 0.12.0"
}

variable "resource_group_name" {
  default = "my-rg"
  description = "The name of the resource group"
}

variable "resource_group_location" {
  default = "westus"
  description = "The location of the resource group"
}

variable "app_service_plan_name" {
  default     = "my-asp"
  description = "The name of the app service plan"
}

variable "app_service_name_prefix" {
  default     = "my-appsvc"
  description = "The beginning part of the app service name"
}

resource "random_integer" "app_service_name_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "my" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "my" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.my.location
  resource_group_name = azurerm_resource_group.my.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "my" {
  name                = "${var.app_service_name_prefix}-${random_integer.app_service_name_suffix.result}"
  location            = azurerm_resource_group.my.location
  resource_group_name = azurerm_resource_group.my.name
  app_service_plan_id = azurerm_app_service_plan.my.id
}

output "website_hostname" {
  value       = azurerm_app_service.my.default_site_hostname
  description = "The hostname of the website"
}
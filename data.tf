data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "rg" {
  name = "test-day7-rg"
}
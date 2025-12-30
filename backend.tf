terraform {
  backend "azurerm" {
    resource_group_name  = "test-day7-rg"
    storage_account_name = "testadityday7"
    container_name       = "tfstate"
    key                  = "policy.terraform.tfstate"
  }
}

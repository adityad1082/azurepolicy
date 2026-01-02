terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-policy-rg"
    storage_account_name = "testpolicyterraform1dev" # Must be globally unique
    container_name       = "tfstate-dev"
    key                  = "environment/terraform.tfstate-dev"
  }
}

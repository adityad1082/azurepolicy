data "azurerm_subscription" "current" {}

output "current_subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
  description = "The GUID of the current Azure Subscription"
}

output "current_tenant_id" {
  value = data.azurerm_subscription.current.tenant_id
  description = "The Tenant ID of the current Azure Subscription"
}

output "current_display_name" {
  value = data.azurerm_subscription.current.display_name
  description = "The display name of the current Azure Subscription"
}


data "azurerm_resource_group" "policy_rg" {
  name = "terraform-policy-rg"
}

output "id" {
  value = data.azurerm_resource_group.policy_rg.id
}
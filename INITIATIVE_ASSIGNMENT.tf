resource "azurerm_resource_group_policy_assignment" "initiative_policy_assignment" {
  name                 = "Policy Assignment Builtin and Custom"
  display_name         = "Terraform Policy Assignment Builtin and Custom"
  policy_definition_id = azurerm_policy_set_definition.initiative_policy.id
  location             = "eastus"
  resource_group_id    = data.azurerm_resource_group.policy_rg.id

  identity {
    type = "SystemAssigned"
  }
}
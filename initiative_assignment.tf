resource "azurerm_resource_group_policy_assignment" "assignment" {
  name                 = "Aditya Initiative TF"
  policy_definition_id = azurerm_policy_set_definition.Initiative.id
  display_name = "Aditya Initiative TF"
  resource_group_id = data.azurerm_resource_group.rg.id
  location = "eastus"

   identity {
    type = "SystemAssigned"
  }

}
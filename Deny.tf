resource "azurerm_policy_definition" "policy1" {
  name         = "Storage accounts should disable public network access Custom"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Storage accounts should disable public network access Custom"

  metadata = <<METADATA
    {
    "category": "Storage",
    "version" : "1.0.1"
    }

METADATA

parameters = <<PARAMETERS
 {
   "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy"
        },
        "allowedValues": [
          "Audit",
          "Deny",
          "Disabled"
        ],
        "defaultValue": "Audit"
      }
  }
PARAMETERS

  policy_rule = <<POLICY_RULE
 {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Storage/storageAccounts"
          },
          {
            "field": "Microsoft.Storage/storageAccounts/publicNetworkAccess",
            "notEquals": "Disabled"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
  }
POLICY_RULE

}

resource "azurerm_subscription_policy_assignment" "example" {
  name                 = "Storage accounts should disable public network access"
  policy_definition_id = azurerm_policy_definition.policy1.id
  subscription_id      = data.azurerm_subscription.current.id
}

resource "azurerm_resource_group_policy_assignment" "example2" {
  name                 = "Storage accounts should disable public network access RG"
  policy_definition_id = azurerm_policy_definition.policy1.id
  resource_group_id    = data.azurerm_resource_group.rg.id
}
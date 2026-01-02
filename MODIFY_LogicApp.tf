resource "azurerm_policy_definition" "logic_app_https" {
  name         = "Configure-LogicApp-Standard-HTTPS"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Configure Logic App Standard to only be accessible over HTTPS"
  description  = "Ensures Logic App Standard uses HTTPS only."

  metadata = <<METADATA
{
  "category": "Logic Apps",
  "version": "1.0.0"
}
METADATA

  policy_rule = <<POLICY
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Web/sites"
      },
      {
        "field": "kind",
        "contains": "workflowapp"
      },
      {
        "anyOf": [
          {
            "field": "Microsoft.Web/sites/httpsOnly",
            "exists": false
          },
          {
            "field": "Microsoft.Web/sites/httpsOnly",
            "equals": false
          }
        ]
      }
    ]
  },
  "then": {
    "effect": "[parameters('effect')]",
    "details": {
      "roleDefinitionIds": [
        "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
      ],
      "operations": [
        {
          "operation": "addOrReplace",
          "field": "Microsoft.Web/sites/httpsOnly",
          "value": true
        }
      ]
    }
  }
}
POLICY

  parameters = <<PARAMETERS
{
  "effect": {
    "type": "String",
    "allowedValues": [ "Modify", "Disabled" ],
    "defaultValue": "Modify",
    "metadata": {
      "displayName": "Effect",
      "description": "Enable or disable HTTPS enforcement"
    }
  }
}
PARAMETERS
}

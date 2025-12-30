resource "azurerm_policy_definition" "policy3" {
  name         = "Function apps should disable SSH"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Function apps should disable SSH"

  metadata = <<METADATA
    {
    "category": "App Service",
    "version" : "1.0.0"
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
            "equals": "Microsoft.Web/sites"
          },
          {
            "field": "kind",
            "contains": "functionapp"
          },
          {
            "field": "kind",
            "notContains": "workflowapp"
          },
          {
            "field": "kind",
            "notContains": "azurecontainerapps"
          },
          {
            "anyOf": [
              {
                "field": "Microsoft.Web/sites/sshEnabled",
                "exists": "false"
              },
              {
                "field": "Microsoft.Web/sites/sshEnabled",
                "notEquals": "false"
              }
            ]
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
  }
POLICY_RULE

}
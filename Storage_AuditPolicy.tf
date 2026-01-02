resource "azurerm_policy_definition" "storage_acc_rm_resources" {
  name         = "Storage Account should be migrated to new ARM"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Storage Account should be migrated to new ARM"
  description  = "Use new Azure Resource Manager for your storage account to provide security enhancements such as: stronger access control (RBAC), better auditing, Azure Resource Manager based deployment and governance, access to managed identities, access to key vault for secrets, Azure AD-based authentication and support for tags and resource groups for easier security management"

  metadata = <<METADATA
    {
    "category": "Storage",
    "version" : "1.0.0"
    }

METADATA


  policy_rule = <<POLICY_RULE
 {
    "if": {
        "allOf": [
          {
            "field": "type",
            "in": [
              "Microsoft.ClassicStorage/storageAccounts",
              "Microsoft.Storage/storageAccounts"
            ]
          },
          {
            "value": "[field('type')]",
            "equals": "Microsoft.Storage/storageAccounts"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
  }
POLICY_RULE


  parameters = <<PARAMETERS
 {
    "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "The effect determines what happens when the policy rule is evaluated to match"
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

}
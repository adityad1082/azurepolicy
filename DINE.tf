resource "azurerm_policy_definition" "policy2" {
  name         = "Configure App Service app slots to FTP deployments"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Configure App Service app slots to FTP deployments"

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
          "DeployIfNotExists",
          "Disabled"
        ],
        "defaultValue": "DeployIfNotExists"
      }
  }
PARAMETERS

  policy_rule = <<POLICY_RULE
 {
         "if": {
        "field": "type",
        "equals": "Microsoft.Web/sites/slots"
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "name": "ftp",
          "type": "Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies",
          "existenceCondition": {
            "field": "Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies/allow",
            "equals": "false"
          },
          "roleDefinitionIds": [
            "/providers/Microsoft.Authorization/roleDefinitions/de139f84-1756-47ae-9be6-808fbbe84772"
          ],
          "deployment": {
            "properties": {
              "mode": "incremental",
              "parameters": {
                "siteName": {
                  "value": "[field('fullName')]"
                },
                "location": {
                  "value": "[field('location')]"
                }
              },
              "template": {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                  "siteName": {
                    "type": "string"
                  },
                  "location": {
                    "type": "string"
                  }
                },
                "variables": {},
                "resources": [
                  {
                    "type": "Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies",
                    "name": "[concat(parameters('siteName'), '/ftp')]",
                    "apiVersion": "2021-02-01",
                    "location": "[parameters('location')]",
                    "tags": {},
                    "properties": {
                      "allow": "false"
                    }
                  }
                ]
              }
            }
          }
        }
      }
  }
POLICY_RULE

}
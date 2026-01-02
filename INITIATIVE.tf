resource "azurerm_policy_set_definition" "initiative_policy" {
  name         = "policy for logic app, storage acc and builtin policies"
  policy_type  = "Custom"
  display_name = "policy for logic app, storage acc and builtin policies"
  description  = "policy set for booth custom and builtin policies"


  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.logic_app_https.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "Modify"}
    }
    VALUE
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.storage_acc_rm_resources.id
    parameter_values     = <<VALUE
    {
      "effect": {"value": "Audit"}
    }
    VALUE
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb"
    parameter_values     = <<VALUE
    {
      "effect": {"value": "DeployIfNotExists"}
    },
    {
      "effect": {"value": "DeployIfNotExists"}
    }
    VALUE
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c285a320-8830-4665-9cc7-bbd05fc7c5c0"
    parameter_values     = <<VALUE
    {
      "effect": {"value": ""}
    }
    VALUE
  }
}
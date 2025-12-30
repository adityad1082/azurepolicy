resource "azurerm_policy_set_definition" "Initiative" {
  name         = "Aditya Initiative TF"
  policy_type  = "Custom"
  display_name = "Aditya Initiative TF"


  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b2982f36-99f2-4db5-8eff-283140c09693"
    reference_id = "Storage accounts should disable public network access"

    parameter_values = jsonencode({
    effect = {
        value = "Deny"
    }
    })
  }
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a06d0189-92e8-4dba-b0c4-08d7669fce7d"
    reference_id = "Configure storage accounts to disable public network access" 

    parameter_values = jsonencode({
    effect = {
        value = "Modify"
    }
    })
}
policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cca5adfe-626b-4cc6-8522-f5b6ed2391bd"
    reference_id = "Configure App Service app slots to turn off remote debugging" 

    parameter_values = jsonencode({
    effect = {
        value = "DeployIfNotExists"
    }
    })
}
policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.policy1.id
    reference_id = "Storage accounts should disable public network access Custom" 

    parameter_values = jsonencode({
    effect = {
        value = "Deny"
    }
    })
}
policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.policy2.id
    reference_id = "Configure App Service app slots to disable local authentication for FTP deployments" 

    parameter_values = jsonencode({
    effect = {
        value = "DeployIfNotExists"
    }
    })
}
policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.policy3.id
    reference_id = "Function apps should disable SSH" 

    parameter_values = jsonencode({
    effect = {
        value = "Deny"
    }
    })
}
}
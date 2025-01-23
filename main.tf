provider "azurerm" {
  features {}
}

resource "azurerm_management_group" "contributor" {
  display_name = "contributor-management-group"
  name         = "contributor-mg"
}

resource "azurerm_role_definition" "custom_contributor_without_vnet" {
  name        = "Custom Contributor Without VNet"
  scope       = azurerm_management_group.contributor.id
  description = "Contributor role without the ability to create or modify virtual networks."

  permissions {
    actions = [
      "*"
    ]
    not_actions = [
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/virtualNetworks/subnets/delete"
    ]
  }

  assignable_scopes = [
    azurerm_management_group.contributor.id
  ]
}

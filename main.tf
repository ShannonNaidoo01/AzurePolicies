provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

resource "azurerm_management_group" "example" {
  display_name = "example-management-group"
  name         = "example-mg"
}

resource "azurerm_role_definition" "custom_example_without_vnet" {
  name        = "Custom example Without VNet"
  scope       = azurerm_management_group.example.id
  description = "example role without the ability to create or modify virtual networks."

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
    azurerm_management_group.example.id
  ]
}
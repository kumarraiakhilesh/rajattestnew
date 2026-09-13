data "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastion
  name                 = try(each.value.subnet_name, "AzureBastionSubnet")
  virtual_network_name = try(each.value.virtual_network_name, "akhilesh_vnet")
  resource_group_name  = try(each.value.resource_group_name, "akhilesh_RG")
}

resource "azurerm_public_ip" "bastion_pip" {
  for_each            = var.bastion
  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.bastion_pip[each.key].id
  }
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnetblock[each.key].id 
    private_ip_address_allocation = "Dynamic"
  }
}
data "azurerm_subnet" "datasubnetblock" {
  for_each             = var.nic
  name                 = try(each.value.subnet_name, "akhilesh_frontend_subnet")
  virtual_network_name = try(each.value.virtual_network_name, "akhilesh_vnet")
  resource_group_name  = try(each.value.resource_group_name, "akhilesh_RG")
}


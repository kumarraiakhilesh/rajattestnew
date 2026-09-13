resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # Rule for SSH (Port 22)
  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "*"
  }
  # Rule for HTTP (Port 80)
  security_rule {
    name                       = "allow-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Existing NIC Data
data "azurerm_network_interface" "nic" {
  for_each            = var.nsg
  name                = try(each.value.nic_name, "akhilesh_nic")
  resource_group_name = try(each.value.resource_group_name, "akhilesh_RG")
}
# NSG Association with VM (NIC)
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  for_each                  = var.nsg
  network_interface_id      = data.azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
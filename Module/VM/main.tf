
# 🔹 Data NIC (if single VM only)
data "azurerm_network_interface" "akhilesh_data" {
  for_each            = var.virtual_machine
  name                = try(each.value.nic_name, "akhilesh_nic")
  resource_group_name = try(each.value.resource_group_name, "akhilesh_RG")
}

# 🔹 Linux VM (recommended resource)
resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.virtual_machine

  name                = each.value.name
  computer_name       = replace(each.value.name, "_", "-")
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size

  network_interface_ids = [
    data.azurerm_network_interface.akhilesh_data[each.key].id
  ]

  admin_username = "testadmin"
  admin_password = "Password1234!"

  disable_password_authentication = false

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # 🔥 NGINX auto install
  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx
echo "<h1>Welcome from Akhilesh Terraform VM</h1>" > /var/www/html/index.html
EOF
  )

  tags = {
    environment = "staging"
  }
}
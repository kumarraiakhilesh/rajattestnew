resource "azurerm_storage_account" "akhilesh_storage" {
  for_each = var.storage_accounts
  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
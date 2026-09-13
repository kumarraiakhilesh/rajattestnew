resource "azurerm_storage_container" "akhilesh_container" {
  for_each              = var.storage_containers
  name                  = each.value.name
  storage_account_id    = data.azurerm_storage_account.akhilesh_storagedata[each.key].id
  container_access_type = each.value.container_access_type
}

data "azurerm_storage_account" "akhilesh_storagedata" {
  for_each            = var.storage_containers
  name                = try(each.value.storage_account_name, "akhileshstorage3prep")
  resource_group_name = try(each.value.resource_group_name, "akhilesh_RG")
}
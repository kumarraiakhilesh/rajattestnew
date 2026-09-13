terraform {
 backend "azurerm" {
    resource_group_name  = "rajat_pipi"
    storage_account_name = "rajattestpipe"
    container_name       = "rtajatcont"
 }
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
features {}
subscription_id = "974dc80c-fc30-43c1-96a6-106db3c5d9c9"
}
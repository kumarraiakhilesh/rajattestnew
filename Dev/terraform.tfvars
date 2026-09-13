resource_groups = {
  rg1 = {
    name     = "akhilesh_RG_dev"
    location = "japan east"
  }
}
storage_accounts = {
  St1 = {
    name                = "akhileshstorage1dev"
    location            = "japan east"
    account_tier        = "Standard"
    replication_type    = "LRS"
    resource_group_name = "akhilesh_RG_dev"
  }
}
storage_containers = {
  st1 = {
    name                  = "akhileshcontainer1dev"
    container_access_type = "private"
    storage_account_name  = "akhileshstorage1dev"
    resource_group_name   = "akhilesh_RG_dev"
  }
}
virtual_networks = {
  Vnet1 = {
    name                = "akhilesh_vnet_dev"
    location            = "japan east"
    resource_group_name = "akhilesh_RG_dev"
    address_space       = ["10.0.0.0/16"]
  }
}
subnet = {
  subnet1 = {
    name                 = "akhilesh_backend_subnet_dev"
    resource_group_name  = "akhilesh_RG_dev"
    virtual_network_name = "akhilesh_vnet_dev"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "akhilesh_frontend_subnet_dev"
    resource_group_name  = "akhilesh_RG_dev"
    virtual_network_name = "akhilesh_vnet_dev"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "akhilesh_RG_dev"
    virtual_network_name = "akhilesh_vnet_dev"
    address_prefixes     = ["10.0.3.0/26"]
  }
  subnet4 = {
    name                 = "akhilesh_appgw_subnet_dev"
    resource_group_name  = "akhilesh_RG_dev"
    virtual_network_name = "akhilesh_vnet_dev"
    address_prefixes     = ["10.0.4.0/24"]
  }
}
public_ip = {
  public_ip1 = {
    name                = "acceptanceTestPublicIp1_dev"
    resource_group_name = "akhilesh_RG_dev"
    location            = "japan east"
    allocation_method   = "Static"
  }
}
nic = {
  nic1 = {
    name                 = "akhilesh_nic_dev"
    resource_group_name  = "akhilesh_RG_dev"
    location             = "japan east"
    virtual_network_name = "akhilesh_vnet_dev"
    subnet_name          = "akhilesh_frontend_subnet_dev"
  }
}
virtual_machine = {
  vm1 = {
    name                = "akhilesh_vm_dev"
    location            = "japan east"
    resource_group_name = "akhilesh_RG_dev"
    vm_size             = "Standard_D2s_v3"
    nic_name            = "akhilesh_nic_dev"
  }
}
nsg = {
  nsg1 = {
    name                = "akhilesh-nsg-dev"
    location            = "japan east"
    resource_group_name = "akhilesh_RG_dev"
    nic_name            = "akhilesh_nic_dev"
  }
}
bastion = {
  bastion1 = {
    name                 = "akhilesh-bastion-dev"
    location             = "japan east"
    resource_group_name  = "akhilesh_RG_dev"
    public_ip_name       = "bastion-pip-dev"
    virtual_network_name = "akhilesh_vnet_dev"
    subnet_name          = "AzureBastionSubnet"
  }
}
app_gateway = {
  appgw1 = {
    name                 = "akhilesh-appgateway-dev"
    location             = "japan east"
    resource_group_name  = "akhilesh_RG_dev"
    public_ip_name       = "appgw-pip-dev"
    virtual_network_name = "akhilesh_vnet_dev"
    subnet_name          = "akhilesh_appgw_subnet_dev"
    nic_name             = "akhilesh_nic_dev"
  }
}
module "rg" {
  source          = "../../Module/RG"
  resource_groups = var.resource_groups
}

module "storage" {

  source           = "../../Module/storage"
  storage_accounts = var.storage_accounts
  
  depends_on = [module.rg]
}
module "storage_containers" {
  depends_on         = [module.storage]
  source             = "../../Module/Conatiners"
  storage_containers = var.storage_containers
}
module "virtual_networks" {
  depends_on       = [module.rg]
  source           = "../../Module/Vnet"
  virtual_networks = var.virtual_networks
}
module "subnet" {
  depends_on = [module.virtual_networks]
  source     = "../../Module/Subnet"
  subnet     = var.subnet
}

module "public_ip" {
  depends_on = [module.rg]
  source     = "../../Module/Public ip"
  public_ip  = var.public_ip
}
module "nic" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../Module/NIC"
  nic        = var.nic
}
module "virtual_machine" {
  depends_on      = [module.nic]
  source          = "../../Module/VM"
  virtual_machine = var.virtual_machine
}

module "nsg" {
  depends_on = [module.nic]
  source     = "../../Module/NSG"
  nsg        = var.nsg
}

module "bastion" {
  depends_on = [module.subnet]
  source     = "../../Module/Bastion"
  bastion    = var.bastion
}

module "app_gateway" {
  depends_on  = [module.subnet, module.virtual_machine]
  source      = "../../Module/ApplicationGateway"
  app_gateway = var.app_gateway
}
# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    count               = length(var.vms)
    name                = "kubernetesnet-${var.vms[count.index]}"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
    count                  = length(var.vms)
    name                   = "terraformsubnet-${var.vms[count.index]}"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet[count.index].name
    address_prefixes       = ["10.0.${count.index + 1}.0/24"]

}

# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic" {
  count               = length(var.vms)
  name                = "vmnic-${var.vms[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration-${var.vms[count.index]}"
    subnet_id                      = azurerm_subnet.mySubnet[count.index].id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.${count.index + 1}.10"
    public_ip_address_id           = azurerm_public_ip.myPublicIp[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp" {
  count               = length(var.vms)
  name                = "vmip-${var.vms[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
provider   "azurerm"   { 
   version   =   ">= 3.25.0" 
   features   {} 
 } 

 locals {
   resource_group = "training" 
   location = "northeurope"
 }

 resource   "azurerm_virtual_network"   "myvnet"   { 
   name   =   "my-vnet" 
   address_space   =   [ "10.0.0.0/16" ] 
   location   =   local.location
   resource_group_name   =   local.resource_group
 } 

 resource   "azurerm_subnet"   "frontendsubnet"   { 
   name   =   "frontendSubnet" 
   resource_group_name   =    local.resource_group
   virtual_network_name   =   azurerm_virtual_network.myvnet.name 
   address_prefixes   =   ["10.0.1.0/24" ]
 } 

 resource   "azurerm_public_ip"   "myvm1publicip"   { 
   name   =   "pip1" 
   location   =   local.location
   resource_group_name   =   local.resource_group
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 } 

 resource   "azurerm_network_interface"   "myvm1nic"   { 
   name   =   "myvm1-nic" 
   location   =   local.location
   resource_group_name   =   local.resource_group

   ip_configuration   { 
     name   =   "ipconfig1" 
     subnet_id   =   azurerm_subnet.frontendsubnet.id 
     private_ip_address_allocation   =   "Dynamic" 
     public_ip_address_id   =   azurerm_public_ip.myvm1publicip.id 
   } 
 } 

 resource   "azurerm_windows_virtual_machine"   "example"   { 
   name                    =   "myvm1"   
   location                =  local.location
   resource_group_name     =   local.resource_group
 
   network_interface_ids   =   [ azurerm_network_interface.myvm1nic.id ] 
   size                    =   "Standard_B1s" 
   admin_username          =   "adminuser" 
   admin_password          =   "Password123!" 

   source_image_reference   { 
     publisher   =   "MicrosoftWindowsServer" 
     offer       =   "WindowsServer" 
     sku         =   "2019-Datacenter" 
     version     =   "latest" 
   } 

   os_disk   { 
     caching             =   "ReadWrite" 
     storage_account_type   =   "Standard_LRS" 
   } 
 } 


variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "web_server_rg" {}
variable "resource_prefix" {}
variable "web_server_name" {}
variable "environment" {}
variable "web_server_count" {}
variable "terraform_script_version" {}
variable "domain_name_label" {}
variable "jump_server_location" {}
variable "jump_server_prefix" {}
variable "jump_server_name" {}

provider "azurerm" {
  version         = "1.16"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
}

variable "resource_group_name" { }

module "windowsservers" {
source = "github.com/Azure/terraform-azurerm-compute.git"
location = "West US 2"
vm_hostname = "mywinvm"
admin_password = "ComplxP@ssw0rd!"
vm_os_simple = "WindowsServer"
is_windows_image = true
public_ip_dns = ["winsimplevmips"] // change to a unique name per datacenter region
vnet_subnet_id = "${module.network.vnet_subnets[0]}"
}

module "network" {
    source = "Azure/network/azurerm"
    location = "East US 2"
    resource_group_name = "myResourceGroup"
}

output "vm_public_name" {
    value = "${module.mycompute.public_ip_dns_name}"
}

output "vm_public_ip" {
    value = "${module.mycompute.public_ip_address}"
}

output "vm_private_ips" {
    value = "${module.mycompute.network_interface_private_ip}"
}
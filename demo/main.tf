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


resource "azurerm_resource_group" "web_server_rg" {
    name     = "${var.resource_prefix}"
    location = "eastus"

    tags {
        environment = "Terraform Demo"
    }
}
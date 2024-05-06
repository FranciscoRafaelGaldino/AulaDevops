terraform {
  backend "azurerm" {
    
  }
} 


provider "azurerm" {
  features{}  
}


variable "location" {
  type = string
  default = "westeurope"
}

resource "azurerm_ressource_group" "rg" {
  name = "rg-sitehtml-${terraform.workspace}"
  location = var.location  
}


resource "azurerm_storage_account" "site" {
  name = "blobhtmlsitetf${terraform.workspace}"
  resource_group_name = azurerm_ressource_group.rg.name
  location = azurerm_ressource_group.rg.location
  account_kind = "StorageV2"
  access_tier = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true

  static_website {
  index_document = "index.html"
  }

}
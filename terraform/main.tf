# We first specify the terraform provider.
# Terraform will use the provider to ensure that we can work with Microsoft Azure

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.91.0"
    }
  }
}

# Here we need to mention the Azure AD Application Object credentials to allow us to work with
# our Azure account

provider "azurerm" {
  subscription_id = "235f406f-3f36-480a-a7c4-6cab6315e8f2"
  client_id       = "baee55b2-5c50-4b49-87f6-2dd0d12b6614"
  client_secret   = "HWK8Q~BHa14IoUJgGUi2wz6-HNiwbzsmLpM-XaAx"
  tenant_id       = "1cb470ea-28cb-4138-904f-0516fd3a8618"
  skip_provider_registration = true
  features {}
}

# The resource block defines the type of resource we want to work with
# The name and location are arguements for the resource block

resource "azurerm_resource_group" "sk_grp"{
  name="sk-new"
  location="Central India"
}

# Here we are creating a storage account.
# The storage account service has more properties and hence there are more arguements we can specify here

resource "azurerm_storage_account" "storage_account" {
  name                     = "skstacc30"
  resource_group_name      = "sk-new"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

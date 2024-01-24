# We first specify the terraform provider. 
# Terraform will use the provider to ensure that we can work with Microsoft Azure

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.88.0"
    }
  }
}

# Here we need to mention the Azure AD Application Object credentials to allow us to work with 
# our Azure account

provider "azurerm" {
  subscription_id = "f231ecf7-d2da-4999-9062-528f2ceeaa1f"
  client_id       = "21247b61-2675-4941-9fe8-30861aa99418"
  client_secret   = "X3D8Q~FqyYOUmQ1UHLAk.Bkp7oxwndoLxa1wHb9O"
  tenant_id       = "66fca911-a422-4197-b03e-8057ca45313c"
  features {}
}

# The resource block defines the type of resource we want to work with
# The name and location are arguements for the resource block

resource "azurerm_resource_group" "sk_grp"{
  name="sk-grp"
  location="Central India"
}

# Here we are creating a storage account.
# The storage account service has more properties and hence there are more arguements we can specify here

resource "azurerm_storage_account" "storage_account" {
  name                     = "skstacc30"
  resource_group_name      = "sk-grp"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

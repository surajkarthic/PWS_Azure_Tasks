terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

# Here we need to mention the Azure AD Application Object credentials to allow us to work with
# our Azure account

provider "azurerm" {
  subscription_id = "f231ecf7-d2da-4999-9062-528f2ceeaa1f"
  client_id       = "21247b61-2675-4941-9fe8-30861aa99418"
  client_secret   = "client-secret"
  tenant_id       = "66fca911-a422-4197-b03e-8057ca45313c"
  skip_provider_registration = true
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "skresource1"
  location = "Central India"
}

resource "azurerm_storage_account" "storage" {
  name                     = "skaccstweb3009"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document         = "index.html"
  }
}

resource "azurerm_storage_container" "static" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.static.name
  type                   = "Block"
  source                 = "/home/suraj/terratut/index.html"  # Replace with your local index.html path
  content_type           = "text/html"
}

output "website_url" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}

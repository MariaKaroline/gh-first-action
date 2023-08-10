# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }

  # required_version = ">= 3.5.0"
}

provider "azurerm" {
  features {}

  client_id       = "689c2c8a-ea3e-453b-b731-4a2fd9a5f24d"
  client_secret   = "RsR8Q~rLD_~7lstCVMg1L-LLaOBkf4xjFCl8MbeJ"
  subscription_id = "6b24130e-18f4-4fa7-a72d-b734cb4e5bc7"
  tenant_id       = "9d1a09cf-4dcb-4bba-890f-71cdc69a6498"
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = "rg-teste"
  location = var.location
}

resource "azurerm_app_service_plan" "serviceplan" {
  name                = "appserviceplan-teste"
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "app-service"
  location            = var.location
  resource_group_name =  azurerm_resource_group.resourcegroup.name
  app_service_plan_id = azurerm_app_service_plan.serviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}


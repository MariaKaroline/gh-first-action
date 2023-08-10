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

  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
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


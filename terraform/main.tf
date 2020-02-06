
terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = ">=1.30.0"
  }
}

provider "azurerm" {
  version = ">=1.30.0"

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.cl
}


locals {
  tags = {
    createBy = "Romain Lenoir"
    project = "aucun"
    lead = "Romain Lenoir"
  }
}

# ======================================================================================
# Ressource Group
# ======================================================================================


# ======================================================================================
# Container Group & Container Instance
# ======================================================================================

resource "azurerm_container_group" "test" {
  name                = "ci-test-recette"
  location            = "North Europe"
  resource_group_name = "rg-romainlenoir"
  ip_address_type     = "public"
  os_type             = "linux"
  dns_name_label      = "angularti-recette"

  image_registry_credential {
    server   = var.server
    username = var.username
    password = var.password
  }

  container {
    name   = "citestdev"
    image  = "crtestci.azurecr.io/bluexyi/angular-ti-recette:latest"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  tags = local.tags
}




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
  client_secret   = var.client_secret
}

locals {
  tags = {
    createBy = "Romain Lenoir"
    project = "Devoir ESGI"
  }
}

# ======================================================================================
# Ressource Group
# ======================================================================================

resource "azurerm_resource_group" "test" {
  name     = "rg-romainlenoir"
  location = "North Europe"

  tags = local.tags
}

# ======================================================================================
# Container Group & Container Instance
# ======================================================================================

resource "azurerm_container_group" "test" {
  name                = "ci-test-recette"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  ip_address_type     = "public"
  os_type             = "linux"
  dns_name_label      = "devoir-esgi"

  /*
  //Authentification container registry
  image_registry_credential {
    server   = "hub.docker.com"
    username = "yourusername1"
    password = "yourpassword"
  }*/

  container {
    name   = "front-devoir-esgi"
    image  = "romainlenoir/front-devoir-cloud-esgi-nginx"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  tags = local.tags
}

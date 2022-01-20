terraform { 
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "terraform_RG" {
  name = "terraform_workspace"
  location = "UK West"
}

resource "azurerm_container_group" "terraform_CG" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.terraform_RG.location
  resource_group_name       = azurerm_resource_group.terraform_RG.name

  ip_address_type     = "public"
  dns_name_label      = "weatherapi"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "afaridarko/docker-repo:weatherapi"
        cpu           = "1"
        memory        = "1"

        ports {
            port      = 80
            protocol  = "TCP"
        }
  }
}
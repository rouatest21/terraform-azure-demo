# -------------------------------
# 1️⃣ Provider Azure
# -------------------------------
provider "azurerm" {
  features {}
  subscription_id = "2f1c6bd5-4fce-40d1-988a-f9469111e6fe"
}

# -------------------------------
# 2️⃣ Groupe de ressources
# -------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-demo-container"
 location = "swedencentral"

}

# -------------------------------
# 3️⃣ Génère un ID aléatoire pour le DNS
# -------------------------------
resource "random_id" "dns" {
  byte_length = 4
}

# -------------------------------
# 4️⃣ Container NGINX
# -------------------------------
resource "azurerm_container_group" "container" {
  name                = "nginx-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "nginx"
    image  = "nginx"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  ip_address_type = "Public"
  dns_name_label  = "demo-nginx-${random_id.dns.hex}"
}

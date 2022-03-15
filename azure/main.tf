locals {
  name = "glory-to-ukraine"
}

resource "azurerm_resource_group" "main" {
  name     = local.name
  location = var.region
}

resource "azurerm_virtual_network" "network" {
  name                = local.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = local.name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.99.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "vms" {
  name                = local.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = var.vm_type
  instances           = var.vm_count
  admin_username      = trimspace(basename(pathexpand("~")))

  #custom_data = "${base64encode(file("${path.module}/script.sh"))}"

  admin_ssh_key {
    username   = trimspace(basename(pathexpand("~")))
    public_key = tls_private_key.ssh.public_key_openssh
  }

  network_interface {
    name    = local.name
    primary = true

    ip_configuration {
      name      = local.name
      primary   = true
      subnet_id = azurerm_subnet.internal.id

      public_ip_address {
        name = local.name
      }
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_monitor_autoscale_setting" "glory_to_ukraine" {
  name                = local.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vms.id

  profile {
    name = local.name

    capacity {
      default = var.vm_count
      minimum = var.vm_count
      maximum = var.vm_count
    }
  }
}

provider "azurerm" {
#   version = "~>1.44.0"
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "folding" {
  name = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "folding" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.folding.name
  location                 = azurerm_resource_group.folding.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_batch_account" "folding" {
  name                 = var.batch_account_name
  resource_group_name  = azurerm_resource_group.folding.name
  location             = azurerm_resource_group.folding.location
  pool_allocation_mode = "BatchService"
  storage_account_id   = azurerm_storage_account.folding.id
}

resource "azurerm_batch_pool" "folding" {
  name                = var.batch_pool_display_name
  resource_group_name = azurerm_resource_group.folding.name
  account_name        = azurerm_batch_account.folding.name
  display_name        = var.batch_pool_display_name
  vm_size             = var.batch_pool_vm_size
  node_agent_sku_id   = var.batch_pool_node_agent_sku_id 

  fixed_scale {
    target_dedicated_nodes    = var.scale_dedicated_nodes
    target_low_priority_nodes = var.scale_low_priority_nodes
    resize_timeout            = "PT15M"
  }

  storage_image_reference {
    publisher = "microsoft-azure-batch"
    offer     = "ubuntu-server-container"
    sku       = "16-04-lts"
    version   = "latest"
  }

  container_configuration {
    type = "DockerCompatible"
    container_registries {
      registry_server = var.container_registry
      user_name       = var.container_user_id
      password        = var.container_user_password
    }
  }

  start_task {
    command_line         = "echo 'Hello World from $USER'"
    max_task_retry_count = 1
    wait_for_success     = true

    environment = {
      USER        = var.fah_user_id
      PASSKEY     = var.fah_user_password
      TEAM        = var.fah_team_id
      ENABLE_GPU  = var.fah_enable_gpu
      ENABLE_SMP  = var.fah_enable_smp
    }

    user_identity {
      auto_user {
        elevation_level = "NonAdmin"
        scope           = "Task"
      }
    }
  }
}

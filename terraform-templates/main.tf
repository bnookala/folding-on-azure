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

#   auto_scale {
#     evaluation_interval = "PT15M"

#     formula = <<EOF
#       startingNumberOfVMs = 1;
#       maxNumberofVMs = 25;
#       pendingTaskSamplePercent = $PendingTasks.GetSamplePercent(180 * TimeInterval_Second);
#       pendingTaskSamples = pendingTaskSamplePercent < 70 ? startingNumberOfVMs : avg($PendingTasks.GetSample(180 *   TimeInterval_Second));
#       $TargetDedicatedNodes=min(maxNumberofVMs, pendingTaskSamples);
# EOF

#   }

  storage_image_reference {
    publisher = "microsoft-azure-batch"
    offer     = "ubuntu-server-container"
    sku       = "16-04-lts"
    version   = "latest"
  }

  container_configuration {
    type = "DockerCompatible"
    container_registries {
      registry_server = "docker.io"
      user_name       = "login"
      password        = "apassword"
    }
  }

  start_task {
    # command_line         = "echo 'Hello World from $env'"
    command_line         = "docker run --name folding-at-home -p 7396:7396 -p 36330:36330 -e USER=Anonymous -e TEAM=0 -e ENABLE_GPU=false -e ENABLE_SMP=true --restart unless-stopped yurinnick/folding-at-home"
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

#   certificate {
#     id         = azurerm_batch_certificate.example.id
#     visibility = ["StartTask"]
#   }
}

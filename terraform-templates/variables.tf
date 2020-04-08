variable "batch_account_name" {
  type = string
}

variable "batch_pool_display_name" {
  type = string
  default = "test-folding-pool-display-name"
}

variable "batch_pool_node_agent_sku_id" {
  type = string
  default = "batch.node.ubuntu 16.04"
  # default = "batch.node.ubuntu 18-04 LTS"
}

variable "batch_pool_vm_size" {
  type = string
  default = "Standard_A1"
  # default = "Standard_F4s"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
  default = "West US 2"
}

variable "storage_account_name" {
  type = string
}


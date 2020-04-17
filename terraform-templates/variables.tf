variable "batch_account_name" {
  type = string
}

variable "batch_pool_display_name" {
  type = string
  default = "azure-folding-at-home"
}

variable "batch_pool_node_agent_sku_id" {
  type = string
  default = "batch.node.ubuntu 18.04"
}

variable "batch_pool_vm_size" {
  type = string
  default = "Standard_F4s_v2"
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
  # default = "West US 2"
  default = "South Central US"
}

variable "scale_dedicated_nodes" {
  type = number
  default = 0
}

variable "scale_low_priority_nodes" {
  type = number
  default = 5
}

variable "storage_account_name" {
  type = string
}

variable "fah_enable_gpu" {
  type = bool
  default = false
}

variable "fah_enable_smp" { // Enabling the SMP Core: https://foldingathome.org/2008/06/15/what-does-the-smp-core-do/
  type = bool
  default = true
}

variable "fah_team_id" {
  type = number
  default = 260105 // MSFT Azure Fold - https://stats.foldingathome.org/team/260105 - Rename to VisualStudio Azure Fold?
}

variable "fah_user_id" {
  type = string
  default = "Anonymous"
}

variable "fah_user_password" {
  type = string
  default = ""
}

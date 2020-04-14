variable "batch_account_name" {
  type = string
}

variable "batch_pool_display_name" {
  type = string
  default = "azure-folding-at-home"
}

variable "batch_pool_node_agent_sku_id" {
  type = string
  default = "batch.node.ubuntu 16.04"
  # default = "batch.node.ubuntu 18-04 LTS" // Targeted for GPU/graphics tasks?
}

variable "batch_pool_vm_size" {
  type = string
  # default = "Standard_A1"
  # default = "Standard_F4s"
  default = "Standard_F4s_v2"
  # default = "Standard_D4_v3"
}

variable "container_registry" {
  type = string
  default = "docker.io"
}

# variable "container_user_id" {
#   type = string
# }

# variable "container_user_password" {
#   type = string
# }

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
  default = 2
}

variable "storage_account_name" {
  type = string
}

variable "fah_enable_gpu" {
  type = bool
  default = false
}

variable "fah_enable_smp" {
  type = bool
  default = true
}

variable "fah_team_id" {
  type = number
  default = 0
}

variable "fah_user_id" {
  type = string
  default = "Anonymous"
}

variable "fah_user_password" {
  type = string
  default = ""
}

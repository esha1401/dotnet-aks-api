variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-integrated-aks"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus2"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "integratedacr0103"
}

variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "integratedaks0103"
}

variable "node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the Virtual Machines"
  type        = string
  default     = "Standard_B2s"
}

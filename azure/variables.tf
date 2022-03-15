variable "region" {
  description = "The Azure region, e.g: East US"
  type        = string
  default     = "Norway East"
}

variable "vm_count" {
  description = "The target number of running instances"
  type        = number
}

variable "vm_type" {
    description = "VM type to run"
    type        = string
    default     = "Standard_B1s"
}

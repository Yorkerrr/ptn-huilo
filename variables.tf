variable "project_id" {
  description = "The GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region, e.g: us-central1"
  type        = string
}

variable "vm_count" {
  description = "The target number of running instances"
}

variable "network" {
    description = "Network name to host vms"
    default = "default"
}

variable "vm_type" {
    description = "VM type to run"
    default = "n1-standard-1"
}

variable "preemptible" {
    description = "Use preemtible vm for cost saving"
    default = true
}
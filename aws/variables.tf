// Default AWS provider vars
variable "region" {
  type        = string
  description = "AWS Region"
}


variable "profile" {
  type        = string
  description = "Profile for AWS credentials"
}

variable "max_size" {
  type        = number
  description = "Max size for autoscaling groups. Both on-demand and spot."
  default     = 32
}

variable "min_size" {
  type        = number
  description = "Min size for autoscale groups. Both on-demand and spot"
  default     = 0
}



variable "on_demand_desired_capacity" {
  type        = number
  description = "number of on-demand instances to launch"
  default = 2

}

variable "on_demand_instance_type" {
  type        = string
  description = "on-demand instance type to use"
  default     = "t3.micro"

}

variable "spot_desired_capacity" {
  type        = number
  description = "number of spot instances to launch"
  default = 2

}

variable "spot_instance_types" {
  description = "list of spot instance types to launch. defaults to empty"
  type        = list(string)
  default     = []
}

variable "spot_max_price" {
  description = "max price for spot instances. same for all the types"
  type        = string
  default     = "0.004"
}

variable "user_data_filename" {
  description = "name of file that will be used as ec2 userdata script"
  type        = string
  default     = "script.sh"
}
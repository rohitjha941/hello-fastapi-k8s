variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Name of the project"
  type        = string
  default     = "hello-flask"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ipv4_cidr" {
  description = "IPv4 CIDR block for IPAM pool (using largest possible private range)"
  type        = string
  default     = "10.0.0.0/8"
}

variable "ipv4_allocation_netmask_length" {
  description = "Default netmask length for IPv4 allocations"
  type        = number
  default     = 16
}

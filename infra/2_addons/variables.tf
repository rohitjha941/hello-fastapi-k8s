variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
}
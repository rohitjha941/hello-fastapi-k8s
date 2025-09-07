data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# Data source to get the IPAM pool by description
data "aws_vpc_ipam_pool" "this" {
  filter {
    name   = "description"
    values = ["${var.name}-ipv4-pool"]
  }
} 
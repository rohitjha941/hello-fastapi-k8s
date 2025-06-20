resource "aws_vpc_ipam_preview_next_cidr" "this" {
  ipam_pool_id = data.aws_vpc_ipam_pool.this.id
}

locals {
  # Split previewed /16 into 2 blocks:
  #   - 10.0.0.0/17 [private]
  #   - 10.0.128.0/17 [public], then further split into smaller
  partitioned = cidrsubnets(aws_vpc_ipam_preview_next_cidr.this.cidr, 1) # 1 bit → 2 subnets

  private_range = local.partitioned[0] # 10.0.0.0/17
  public_range  = local.partitioned[1] # 10.0.128.0/17
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${var.name}-${var.environment}"
  cidr = aws_vpc_ipam_preview_next_cidr.this.cidr

  azs = data.aws_availability_zones.available.names
  
  public_subnets = [
    for i in range(length(data.aws_availability_zones.available.names)) :
    cidrsubnet(local.public_range, 5, i)
  ]

  private_subnets = [
    for i in range(length(data.aws_availability_zones.available.names)) :
    cidrsubnet(local.private_range, 1, i)
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

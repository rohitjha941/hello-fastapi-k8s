resource "aws_vpc_ipam_preview_next_cidr" "this" {
  ipam_pool_id = data.aws_vpc_ipam_pool.this.id
}

locals {
  # 1:8 ratio for public:private
  partitioned = cidrsubnets(aws_vpc_ipam_preview_next_cidr.this.cidr, 4, 1)
  
  public_range  = local.partitioned[0] # 1/8 of space (/20 = 4,096 IPs)
  private_range = local.partitioned[1] # 8/8 of space (/17 = 32,768 IPs)
  
  # Calculate bits needed to divide equally among AZs
  az_count = length(data.aws_availability_zones.available.names)
  subnet_bits = ceil(log(local.az_count, 2))
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.name}-${var.environment}"
  cidr = aws_vpc_ipam_preview_next_cidr.this.cidr

  azs = data.aws_availability_zones.available.names
  
  # Divide public range equally among AZs
  public_subnets = [
    for i in range(local.az_count) :
    cidrsubnet(local.public_range, local.subnet_bits, i)
  ]

  # Divide private range equally among AZs  
  private_subnets = [
    for i in range(local.az_count) :
    cidrsubnet(local.private_range, local.subnet_bits, i)
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
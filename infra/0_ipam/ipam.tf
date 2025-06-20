resource "aws_vpc_ipam" "this" {
  operating_regions {
    region_name = var.aws_region
  }
}

# IPv4 IPAM Pool
resource "aws_vpc_ipam_pool" "this" {
  description                       = "${var.name}-ipv4-pool"
  address_family                    = "ipv4"
  ipam_scope_id                     = aws_vpc_ipam.this.private_default_scope_id
  locale                            = var.aws_region
  allocation_default_netmask_length = var.ipv4_allocation_netmask_length
}

resource "aws_vpc_ipam_pool_cidr" "this" {
  ipam_pool_id = aws_vpc_ipam_pool.this.id
  cidr         = var.ipv4_cidr
}
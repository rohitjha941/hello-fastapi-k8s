output "ipam_id" {
  description = "ID of the IPAM"
  value       = aws_vpc_ipam.this.id
}

output "ipam_arn" {
  description = "ARN of the IPAM"
  value       = aws_vpc_ipam.this.arn
}

output "ipv4_pool_id" {
  description = "ID of the IPv4 IPAM pool"
  value       = aws_vpc_ipam_pool.this.id
}

output "ipv4_pool_arn" {
  description = "ARN of the IPv4 IPAM pool"
  value       = aws_vpc_ipam_pool.this.arn
}
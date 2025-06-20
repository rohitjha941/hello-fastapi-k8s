# # VPC using terraform-aws-modules/vpc/aws
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 6.0"

#   name = "${var.name}-${var.environment}"
#   cidr = var.vpc_cidr

#   azs             = data.aws_availability_zones.available.names
#   public_subnets  = [for i in range(length(data.aws_availability_zones.available.names)) : cidrsubnet(var.vpc_cidr, 8, 1 + i)]
#   private_subnets = [for i in range(length(data.aws_availability_zones.available.names)) : cidrsubnet(var.vpc_cidr, 8, 10 + i)]

#   enable_nat_gateway   = true
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   single_nat_gateway   = true

#   public_subnet_tags = {
#     type                     = "public"
#     "kubernetes.io/role/elb" = "1"
#   }

#   private_subnet_tags = {
#     type                              = "private"
#     "kubernetes.io/role/internal-elb" = "1"
#   }
# }   
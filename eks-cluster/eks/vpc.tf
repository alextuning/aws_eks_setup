resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "eks_subnets" {
  count = length(var.subnet_ids)

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.subnet_ids, count.index)
  availability_zone       = element(var.subnet_ids, count.index)
  map_public_ip_on_launch = true
}

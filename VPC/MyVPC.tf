resource "aws_vpc" "vpc_creation" {
  #count            = length(var.vpc_cidr_ip)
  cidr_block       = var.vpc_cidr_ip
  instance_tenancy = "default"

  tags = {
    Name = var.VPC_Name #.${count.index}"
  }
}

resource "aws_subnet" "privte_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc_creation.id
  availability_zone       = var.subnet_region[count.index]
  cidr_block              = var.vpc_private_subnet_cidr_block[count.index + 1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Private_subnet${count.index}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc_creation.id
  availability_zone       = var.subnet_region[count.index]
  cidr_block              = var.vpc_public_subnet_cidr_block[count.index + 1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet${count.index}"
  }
}

/*output "aws_vpc_id" {
  value = aws_vpc.vpc_creation[*].id
}*/

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_creation.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }

  tags = {
    Name = "Public_Table_${var.VPC_Name}"
  }
}
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_creation.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }

  tags = {
    Name = "Private_Table_${var.VPC_Name}"
  }
}

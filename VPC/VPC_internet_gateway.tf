resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.vpc_creation.id

  tags = {
    Name = "gateway_${var.VPC_Name}"
  }
}

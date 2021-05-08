resource "aws_route_table_association" "public_route_T" {
  count          = 3
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_route_t" {
  count          = 3
  subnet_id      = aws_subnet.privte_subnet[count.index].id
  route_table_id = aws_route_table.private_route.id
}

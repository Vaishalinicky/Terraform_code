/*output "cidr_block" {
  value       = var.vpc_cidr_ip
  description = "The CIDR block associated with the VPC"
}*/
output "VPC_ID1" {
  value       = aws_vpc.vpc_creation
  description = "vpc details"
}

output "public_subnet_vpc" {
  value       = aws_subnet.public_subnet[*]
  description = "subnet details"
}
output "private_subnet_vpc" {
  value       = aws_subnet.privte_subnet[*]
  description = "subnet details"
}

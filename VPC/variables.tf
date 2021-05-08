variable "vpc_cidr_ip" {
  type    = string
  default = "10.0.0.0/16" #, "10.1.0.0/16
}
variable "VPC_Name" {
  type    = string
  default = "VPC"
}
variable "vpc_public_subnet_cidr_block" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}
variable "vpc_private_subnet_cidr_block" {
  type    = list(string)
  default = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
}
variable "subnet_region" {
  type = list(string)
  #default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

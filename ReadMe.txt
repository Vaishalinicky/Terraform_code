1. login into AWS Console
2. Create Policy using below json file with name of "Assume_role"

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "*"
        }
    ]
}

3. Create user using IAM portal in AWS and assigne "sts-user" policy
4. Create a role in AWS "Sts-role"

Assign policy related to EC2 and VPC
and in Trust relation mention the ARN of user 

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::sts-user", #ARN of User with Assume Role
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

5. create a key-pair in aws and download.pem file and rename as "ssh_key.pem" and save this under folder "vpc_EC2"
6. I have configured aws CLI at my end , where i have provided IAM and Access key of sts-user but for simplicity ,added Iam_access_key and Iam_secret_key, kindly provide value according to you in terraform.tfstate file.
7.Use this module as below in terrform file , where you want to use this module.

module "VPC" {
  source = "../Module/VPC/"
  #version     = "3.0.0"
  count                         = 2 #this Module block will be excute 2 time if you want to create two VPC
  vpc_cidr_ip                   = var.vpc_cidr_ip_Details[count.index] #Variable which is having VPC IP details 
  VPC_Name                      = "VPC_${count.index}" #creating VPC Name Dynamically here , As per convinece we can change it 
  subnet_region                 = formatlist("%s", var.vpc_subnet_region) # Creating it for 3 Subnet region
  vpc_private_subnet_cidr_block = cidrsubnets(var.vpc_cidr_ip_Details[count.index], 4, 4, 4, 4) # CIDR blocks as well , depends on user how they want to provide , shown one way here.
  vpc_public_subnet_cidr_block  = cidrsubnets(var.vpc_cidr_ip_Details[count.index], 8, 8, 8, 8)
}

8. try to run code with below steps

terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve

#Note :- All the terraform code is available under folder "vpc_EC2"

Outcome of this code.

1.This module is capable to create multiple VPCs, Each VPC will have 3 Public subnet , 3 Private Subnet
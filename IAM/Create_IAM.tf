terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::171337391740:role/sts-test-role"
    session_name = "sts_session-test"
  }

}

resource "aws_iam_user" "aws_test_user" {
  name = "aws_test01"
  tags = {
    tag-key   = "test_user01"
    tag-value = "vaishali.nicky@gmail.com"
  }
}

resource "aws_iam_group" "group1" {
  name = "group1"
}

resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.group1.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_user_group_membership" "example2" {
  user = aws_iam_user.aws_test_user.name

  groups = [
    aws_iam_group.group1.name,
  ]
}




resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.aws_test_user.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "Admin"
  user = aws_iam_user.aws_test_user.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.lb.ses_smtp_password_v4
}

/*resource "aws_iam_user_login_profile" "example" {
  user = aws_iam_user.aws_test_user.name
  #pgp_key = "keybase:some_person_that_exists"
}

output "password" {
  value = aws_iam_user_login_profile.example.encrypted_password
}*/

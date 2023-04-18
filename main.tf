#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "Access_key"
  secret_key = "Secret_key"
}
#######################################################
#Creating Production VPC with CIDR: 10.0.0.0/16
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16" 
    tags = {
        Name = "Production VPC"
    }
}
output "vpcid" {
  value = aws_vpc.vpc.id
}

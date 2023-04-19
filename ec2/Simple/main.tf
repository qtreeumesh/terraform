#Declaring AWS Provider and credentials
provider "aws" {
  region     = var.region
}
#######################################################
#Creating the baction host
resource "aws_instance" "bastion" {
   ami = "ami-007855ac798b5175e" //change ami id
   instance_type = "t2.micro"
   subnet_id = "subnet-0d0e00fea9e39acba" //change subnet id
   associate_public_ip_address = "true"
   vpc_security_group_ids = ["sg-09f1c4a7a84e1aa98"] //change sg id
   key_name = "test" //change key name
    tags = {
      Name = "Bastion"
    }  
}
output "instance_id"{
    value = aws_instance.bastion.id
}
output "Instance_PublicIP" {
    value = aws_instance.bastion.public_ip
}

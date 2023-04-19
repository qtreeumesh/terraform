#Declaring AWS Provider and credentials
provider "aws" {
  region     = "us-east-2"
  access_key = "**********************"
  secret_key = "**************************"
}
#Launch an EC2 instance
resource "aws_instance" "webserver" {
 ami = "ami-00eeedc4036573771"
 instance_type = "t2.micro"
 key_name = "ohio"
 vpc_security_group_ids = ["sg-0251d7f7ed33799d1"]
 subnet_id = "subnet-0ea9cc4c591e072b8"
 associate_public_ip_address = "true"
 user_data = <<EOF
#!/bin/bash
sudo echo "installing nginx"
sudo apt update && sudo apt install -y nginx
sudo echo "starting nginx service"
sudo systemctl start nginx
sudo mkfs -t ext4 /dev/xvdf
sudo mount /dev/xvdf /mnt
sudo echo /dev/xvdf /mnt defaults,nofail 0 2 >> /etc/fstab
EOF

 tags = {
  Name = "Webserver"
 }
}
output "Webserver_IP" {
  value = aws_instance.webserver.public_ip
}
output "Webserver_instance_id" {
  value = aws_instance.webserver.id
}
resource "aws_ebs_volume" "secondary_volume" {
  availability_zone = "us-east-2b" //mention right AZ where the subnet is
  size              = 10
  type              = "gp2"
   tags = {
  Name = "secondary_volume"
 }
}
output "secondary_volume" {
  value = aws_ebs_volume.secondary_volume.id
}
resource "aws_volume_attachment" "secondary_volume-attach" {
  device_name  = "/dev/xvdf"
  instance_id  = "${aws_instance.webserver.id}"
  volume_id    = "${aws_ebs_volume.secondary_volume.id}"
  force_detach = true
}

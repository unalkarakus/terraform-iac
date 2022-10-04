provider "aws" {
  region = "eu-west-1"
}
resource "aws_instance" "tfvm" {
  ami = "ami-096800910c1b781ba"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.trainingsg.id ]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                echo "I <3 Havelsan!" > /usr/share/nginx/html
                EOF
    tags = {
      Name = "training-demo"
    }
}
resource "aws_security_group" "trainingsg" {
  name = "tr-sg01"
}

output "instance_ips" {
  value = aws_instance.tfvm.public_ip
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = var.sg_name
  description = "Allow HTTP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

# First EC2 Instance
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "Welcome to Terraform demo" > /var/www/html/index.html
  EOF

  tags = {
    Name = "terraform-demo-instance"
  }
}

# AMI from first instance
resource "aws_ami_from_instance" "web_ami" {
  name               = "terraform-demo-ami"
  source_instance_id = aws_instance.web.id
  depends_on         = [aws_instance.web]

  tags = {
    Name = "terraform-demo-ami"
  }
}

# Second EC2 from AMI
resource "aws_instance" "web_from_ami" {
  ami           = aws_ami_from_instance.web_ami.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "terraform-demo-instance-from-ami"
  }
}
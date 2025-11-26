provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# 1️⃣ VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-demo-vpc"
  }
}

# 2️⃣ Internet Gateway for public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-demo-igw"
  }
}

# 3️⃣ Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-demo-public-subnet"
  }
}

# 4️⃣ Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "terraform-demo-private-subnet"
  }
}

# 5️⃣ Route Table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-demo-public-rt"
  }
}

# 6️⃣ Associate route table with public subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id     = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 7️⃣ Security Group for public instances
resource "aws_security_group" "public_sg" {
  name        = "terraform-demo-public-sg"
  description = "Allow HTTP access"
  vpc_id      = aws_vpc.main_vpc.id

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
    Name = "terraform-demo-public-sg"
  }
}

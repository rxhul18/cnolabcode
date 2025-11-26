variable "region" {
  description = "AWS region"
}

variable "access_key" {
  description = "AWS Access Key"
  sensitive   = true
}

variable "secret_key" {
  description = "AWS Secret Key"
  sensitive   = true
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  default     = "ap-south-1"
}

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

variable "instance_type" {
  description = "EC2 instance type"
}

variable "ami" {
  description = "AMI ID to launch first EC2 instance"
}

variable "sg_name" {
  description = "Security group name"
  default     = "terraform-demo-sg"
}
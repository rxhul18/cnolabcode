terraform {
  backend "s3" {
    bucket         = "tf-state-rohit-1045"      # same as output bucket
    key            = "env/dev/terraform.tfstate"  # folder/path inside bucket
    region         = "ap-south-1"
    dynamodb_table = "tf-state-locks-rohit"    # same as output table
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Example resource (you can replace this with anything)
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-rohit-1045"  # must be unique
  acl    = "private"
}

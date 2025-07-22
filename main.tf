terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "github-terraform-statefile-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Create S3 bucket
resource "random_string" "bucket_suffix" {
  length           = 5
  special          = false
  upper            = false
  lower            = true   
}

resource "aws_s3_bucket" "git_s3" {
  bucket = "my-tf-github-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "my-tf-github-bucket"
    Environment = "Dev"
  }
}

# Get Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

# Create EC2 instance (using default vpc, subnets and security group)
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name = "github_instance"
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "devconfcz2023workshop" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "devconfcz2023"
  }
}


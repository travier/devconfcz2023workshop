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

resource "aws_key_pair" "travier" {
  key_name = "travier"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcLpPwysXQ7IVZtgJWmC3g6NfkaDyoStfFlA0f2668f tim@phoenix"
}

resource "aws_instance" "devconfcz2023workshop" {
  ami           = "ami-016a79745fc97446a"
  instance_type = "t2.micro"
  key_name = "travier"
  tags = {
    Name = "devconfcz2023"
  }
  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
  }
  user_data_base64 = "eyJpZ25pdGlvbiI6eyJjb25maWciOnsicmVwbGFjZSI6eyJzb3VyY2UiOiJzMzovL2RldmNvbmZjejIwMjN3b3Jrc2hvcC9jb25maWcuaWduIn19LCJ2ZXJzaW9uIjoiMy4zLjAifX0K"
}

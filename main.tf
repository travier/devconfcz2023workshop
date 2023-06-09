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
  key_name   = "travier"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcLpPwysXQ7IVZtgJWmC3g6NfkaDyoStfFlA0f2668f tim@phoenix"
}

resource "aws_instance" "devconfcz2023workshop" {
  ami           = "ami-016a79745fc97446a"
  instance_type = "m6i.4xlarge"
  key_name      = "travier"
  tags = {
    Name = "devconfcz2023"
  }
  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
  }
  user_data_base64 = "eyJpZ25pdGlvbiI6eyJjb25maWciOnsicmVwbGFjZSI6eyJzb3VyY2UiOiJodHRwczovL2Zjb3Muc2lvc20uZnIvOWNiOTc4NmFhN2Q4MzA5ODA1M2YxNzYwNTY3MWI5MWRiNjZhZTFjOWM3ZmQ1MTBiNzhmYTFiNzhjZTRjMzA2Zi5pZ24ifX0sInZlcnNpb24iOiIzLjMuMCJ9fQo="
}

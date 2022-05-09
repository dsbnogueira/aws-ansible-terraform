terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region_aws
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ee8244746ec5d6d4"
  instance_type = var.flavor
  key_name      = var.chave_ssh
  
  tags = {
    Name = var.nome
  }
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave_ssh
  public_key = file("${var.chave_ssh}.pub")
}

output "public_ip" {
  value = aws_instance.app_server.public_ip  
}

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

resource "aws_key_pair" "default" {
  key_name   = "pub-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_instance" "k8s_node" {
  ami           = "ami-0e54671bdf3c8ed8d"
  instance_type = "t2.micro"

  key_name = aws_key_pair.default.key_name


  tags = {
    Name = "K8snode"
  }
}

output "instance_public_ip" {
  value = aws_instance.k8s_node.public_ip
}


provider "aws" {
  region     = var.my-region
  access_key = var.my-access-key
  secret_key = var.my-secret-key
  token = var.session-token
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_CIDR

  tags = {
    Name = "tf-example-vpc"
  }
}

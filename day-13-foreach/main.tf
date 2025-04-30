provider "aws" {
    region = "ap-south-1"

}

resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    for_each = toset(var.env)
  tags = {
    Name = each.value
  }

}
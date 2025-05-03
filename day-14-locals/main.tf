
 locals {
   region        = "us-east-1"
   instance_type = "t2.micro"
 }
 
 resource "aws_instance" "example" {
   ami           = "ami-062f0cc54dbfd8ef1"
   instance_type = local.instance_type
   tags = {
     Name = "App-${local.region}"
   }
 }
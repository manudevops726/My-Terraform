# # example-1 s3 buvket creation condition based 
 
#  variable "create_bucket" {
#    description = "Set to true to create the S3 bucket."
#    type        = bool
#    default     = true
#  }
 
#  resource "aws_s3_bucket" "example" {
#    count = var.create_bucket ? 1 : 0
#    bucket= "manasadevopstfbucketttttttttt"
# #    acl    = "private"
 
# #    tags = {
# #      Name        = "ConditionalBucket"
# #      Environment = "Dev"
# #    }
#  }
 
 
#  #example-2
#  variable "aws_region" {
#    description = "The region in which to create the infrastructure"
#    type        = string
#    default     = "us-east-1" #here we need to define either us-west-1 or eu-west-2 if i give other region will get error 
#    validation {
#      condition = var.aws_region == "us-west-1" || var.aws_region == "ap-south-1"
#      error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1"
#    }
#  }
#  # any one of the region should be present in conditon line __default region or  in provider block whichever we mentioned region.
#  provider "aws" {
#    region = "eu-west-1"
   
    
#   }
 
#   resource "aws_s3_bucket" "dev" {
#      bucket = "statefile-configuresss"
     
   
#  }
 
 #after run this will get error like The variable 'aws_region' must be one of the following regions: us-west-2,│ eu-west-1, so it will allow any one region defined above in conditin block
 
 # example-4 with numeric condition in thid condition if ec2 instance = t2.micro only instance will create(count = var.instance_type == "t2.micro" ? 1 : 0) but i am passing t2.nano so ec2 will not create
#  variables.tf
 variable "ami" {
   type    = string
   default = "ami-062f0cc54dbfd8ef1"
 }
 
 variable "instance_type" {
   type = string
   default = "t2.micro"
   
 }
 
 # main.tf
 resource "aws_instance" "dev" {
   ami           = var.ami
   instance_type = var.instance_type
   count         = var.instance_type == "t2.micro" ? 1 : 0
   tags = {
     Name = "dev_server"
   }
 }
 
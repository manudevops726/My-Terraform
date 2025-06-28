
# resource "aws_vpc" "dev" {
#     cidr_block = "10.0.0.0/16"
  
# }

# resource "aws_subnet" "dev-1" {
#     cidr_block = "10.0.0.0/24"
#      vpc_id = aws_vpc.dev.id
# }

# resource "aws_subnet" "test" {
#     cidr_block = "10.0.1.0/24"
#      vpc_id = aws_vpc.dev.id

# }
 resource "aws_instance" "name" {
     ami = "ami-002f6e91abff6eb96"
     instance_type = "t2.micro"
  
 }
# resource "aws_subnet" "devops" {
#     cidr_block = "10.0.3.0/24"
#      vpc_id = aws_vpc.dev.id
# }

# resource "aws_subnet" "prod" {
#     cidr_block = "10.0.2.0/24"
#      vpc_id = aws_vpc.dev.id
  
# }

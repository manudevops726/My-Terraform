#vpc creation

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "myvpc"
  }

}


 #subnet creation

 resource "aws_subnet" "public" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"


}
   
 
#pvt subnet

 resource "aws_subnet" "private" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"


 }

#ig creation
resource "aws_internet_gateway" "my-ig" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "my_igw"
    }
}   
 #create routetable for ig
 resource "aws_route_table" "rt-ig" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-ig.id
    }
 }
#subnet association to rt

resource "aws_route_table_association" "rt-ig" {
    route_table_id = aws_route_table.rt-ig.id
    subnet_id = aws_subnet.public.id
    
}
#create eip
resource "aws_eip" "name" {
     domain = "vpc"
   
 }
 resource "aws_nat_gateway" "name" {
     allocation_id = aws_eip.name.id
     subnet_id = aws_subnet.private.id
   
 }
 
 resource "aws_route_table" "private" {
     vpc_id = aws_vpc.myvpc.id
     route {
         cidr_block= "0.0.0.0/0"
         gateway_id = aws_nat_gateway.name.id
     
     }
 
   
 }
 resource "aws_route_table_association" "name" {
     subnet_id = aws_subnet.private.id
     route_table_id = aws_route_table.private.id 
  
 }
     
#create sg

# resource "aws_security_group" "my-sg" {
#   name        = "my-sg"
#   vpc_id      =  aws_vpc.myvpc.id
#   tags = {
#     Name = "my_sg"
#   }
#  ingress {
#     description      = "allow-vpc"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
    
#   }
# ingress {
#     description      = "allow-vpc"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
    
#   }
# egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
    
#   }


#   }
  

# resource "aws_instance" "dev" {
#      ami = "ami-0f1dcc636b69a6438"
#      instance_type = "t2.micro"
#      subnet_id = aws_subnet.public.id
#      associate_public_ip_address = true
#      key_name               = "new-ac"
#      vpc_security_group_ids = [aws_security_group.my-sg.id]
# }
 
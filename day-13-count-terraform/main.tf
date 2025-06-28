resource "aws_instance" "Name" {

     ami = "ami-0f1dcc636b69a6438"
     instance_type = "t2.micro"
     key_name = "new-ac"
     availability_zone = "ap-south-1a"
     count = 2
    
     tags = {
        Name = "dev-${count.index}"
      }
 }



   
 
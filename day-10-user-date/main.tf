resource "aws_instance" "manasa" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    user_data = file("test.sh")
    
}
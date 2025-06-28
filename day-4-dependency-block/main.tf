resource "aws_instance" "prod" {
    ami = "ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
}
resource "aws_vpc" "myvpc" {
    cidr_block = "172.31.0.0/16"
  depends_on = [ aws_instance.prod ]
}
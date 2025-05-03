
 resource "aws_key_pair" "name" {
     key_name = "manu"
     public_key = file("C:/Users/mi/.ssh/id_ed25519.pub") #here you need to define public key file path
 
   
 }


 #Launch server
 resource "aws_instance" "manasa" {
     ami = "ami-062f0cc54dbfd8ef1"
     instance_type = "t2.micro"
    #  subnet_id = aws_subnet.public.id
     associate_public_ip_address = true
     key_name     =  aws_key_pair.name.key_name
    #  vpc_security_group_ids = [aws_security_group.allow_tls.id]
 
     
 }



 #Use taint when you want Terraform to handle recreation without touching .tf code. It’s useful for controlled replacements during debugging or incident response.
 # terraform taint aws_instance.name 
 # terraform untaint aws_instance.name
 #terraform replace is the modern alternative to terraform taint starting from Terraform v1.1+.
 #example command ""terraform plan -replace=aws_instance.name"""
# Define the AWS provider configuration.
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region.
}

# resource "aws_key_pair" "test" {
#   key_name   = "manasa-tf-key"  # The name you want for the key pair
#   public_key = file("~/.ssh/id_rsa.pub")  # Path to the public key file on your local machine

#   # Optional: You can specify a specific region if needed
#   # region = "us-west-2"
# }

resource "aws_key_pair" "Example" {
  key_name   = "manasa-tf-key"
  public_key = file("C:/Users/mi/.ssh/id_ed25519.pub")  # Corrected path
}




resource "aws_instance" "server" {
  ami                    = "ami-0f1dcc636b69a6438"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.Example.key_name
  

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("C:/Users/mi/.ssh/id_ed25519")  # private key path

    host        = self.public_ip
  }
  # local execution procee 
 provisioner "local-exec" {
    command = "touch file500" #mysql -h -u user -p
   
 }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file10"  # Replace with the path to your local file
    destination = "/home/ec2-user/file10"  # Replace with the path on the remote instance
  }
  # remote execution process 
  provisioner "remote-exec" {
    inline = [
"touch file200",
"echo welcome to multicloud+devOps >> file200", ##mysql -h -u user -p
]
 }
}



 
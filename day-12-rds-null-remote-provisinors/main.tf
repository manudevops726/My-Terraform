provider "aws" {
  region = "ap-south-1"
}

# Create the RDS instance
resource "aws_db_instance" "mysql_rds" {
  identifier              = "my-mysql-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Password123!"
  db_name                 = "manasa"
  allocated_storage       = 20
  skip_final_snapshot     = true
  publicly_accessible     = true
}

# Create EC2 instance to run remote commands
resource "aws_instance" "ec2_user" {
  ami                         = "ami-0f1dcc636b69a6438" # Amazon Linux 2 AMI (Make sure this is the correct AMI for your region)
  instance_type               = "t2.micro"
  key_name                    = "new-ac"                # Replace with your key pair name
  associate_public_ip_address = true
  subnet_id                   = "subnet-0135de284073b6d70"  # Ensure your subnet is public and has internet access

  tags = {
    Name = "sql-server-instance"
  }
}

# Upload and execute SQL remotely
resource "null_resource" "remote_sql_exec" {
  depends_on = [aws_db_instance.mysql_rds, aws_instance.ec2_user]

  connection {
    type        = "ssh"
    host        = aws_instance.ec2_user.public_ip
    user        = "ec2-user"
    private_key = file("C:/Users/mi/Downloads/new-ac.pem")
  }

  provisioner "file" {
    source      = "init.sql"           # Ensure your `init.sql` file exists in the same directory as the Terraform script
    destination = "/tmp/init.sql"      # Upload the SQL script to the EC2 instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Updating system...'",
      "sudo yum update -y",                  # Ensure system is up-to-date
      "echo 'Installing MySQL client...'",
      "sudo amazon-linux-extras enable mysql8.0", # Enable MySQL 8.0 on Amazon Linux
      "sudo yum clean metadata",             # Clean old metadata
      "sudo yum install -y mysql",           # Install MySQL client
      "echo 'Sleeping for 60 seconds...'",
      "sleep 60",                             # Sleep to ensure RDS instance is up and ready
      "echo 'Running SQL script against RDS...'",
      "mysql --version",                     # Check if MySQL is installed
      "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -pPassword123! manasa < /tmp/init.sql"  # Run the SQL script
    ]
  }

  triggers = {
    always_run = timestamp()  # Forces the resource to always run, ensuring it runs every time
  }
}

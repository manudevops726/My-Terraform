terraform {
  backend "s3" {
    bucket = "manasadevopsbuckett" 
    key    = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}
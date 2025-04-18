terraform {
  backend "s3" {
    bucket = "manasadevopsbuckett" 
    key    = "day-0/terraform.tfstate"
    region = "ap-south-1"
    
  }
}

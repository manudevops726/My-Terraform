terraform {
  backend "s3" {
    bucket = "manasadevopsbuckettt" 
    key    = "terraform.tfstate"
    region = "ap-south-1"
    
    
  }
}

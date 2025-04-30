variable "env" {
    type = list(string)
    default = [ "aws","gcp","azure" ]

  
}

variable "ami_id" {
    type = string
    default = "ami-0f1dcc636b69a6438"

}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}



############## if delete middle source case #################

variable "env" {
    type = list(string)
    default = [ "aws","azure" ]

  
}

variable "ami_id" {
    type = string
    default = "ami-0f1dcc636b69a6438"

}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

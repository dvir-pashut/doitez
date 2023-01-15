variable "tags" {
  description = "defoult tags"
  type        = map(string)
  default = {
    owner           = "dvir-pashut"
    bootcamp        = "17"
    expiration_date = "01-04-23"
  }

}

variable "region" {
  description = "the region to use"
  default     = "eu-west-3"
}

variable "az1" {
  description = "the first az to use"
  type        = list(any)
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "user_data" {
   default =  <<-EOF
    #!/bin/bash

    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    apt-get update
    apt-get install -y docker-ce
    usermod -aG docker ubuntu 
    newgrp docker
    docker run -d -p 80:3000 adongy/hostname-docker
    EOF

}

variable "ami" {
  description = "the ec2 image"
  default     = "ami-03c476a1ca8e3ebdc"
}

variable "instance_type" {
  description = "the ec2 type"
  default     = "t3a.micro"
}


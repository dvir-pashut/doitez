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
  default     = "eu-central-1"
}

variable "az1" {
  description = "the first az to use"
  type        = list(any)
  default     = ["eu-central-1a", "eu-central-1b"]
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
  default     = "ami-0039da1f3917fa8e3"
}

variable "instance_type" {
  description = "the ec2 type"
  type        = string
  default     = "t3a.micro"
}

variable "sub-ip" {
  description = "ip lists for subnets"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc-ip" {
  description = "vpc-ip"
  default     = "10.0.0.0/16"
}


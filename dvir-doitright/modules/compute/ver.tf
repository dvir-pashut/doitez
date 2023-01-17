variable "tags" {
  description = "defoult tags"
  type        = map(string)
  default = {
    owner           = "dvir-pashut"
    bootcamp        = "17"
    expiration_date = "01-04-23"
  }

}

variable "ami" {
  description = "the ec2 image"
}

variable "instance_type" {
  description = "the ec2 type"
  type        = string
  default     = "t3a.micro"
}


variable "ec2-names" {
  type        = list(string)
  description = "names for the ec2"
}

variable "ec2-count" {
  type        = number
  description = "how many ec2 to make"

  validation {
    condition     = var.ec2-count == 1 || var.ec2-count == 2
    error_message = "not valid number... enter 1 or 2"
  }
}

variable "subnets-id" {
  type        = list(any)
  description = "the subnets id"
}

variable "vpc-id" {
  type        = string
  description = "the vpc id"
}

variable "my-ip" {
  description = "your ip for max security"
  default = ["0.0.0.0/0"]
}
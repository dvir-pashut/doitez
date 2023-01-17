variable "region" {
  description = "the region to use"
  default     = "eu-central-1"
}

variable "number" {
  type = number
  description = "how many ec2 and subnets to upload"
  default = 2
}

variable "ec2-names" {
  type = list
  description = "names for the ec2"
  default = ["ec2-1", "ec2-2"]
}

variable "vpc-name" {
  type = string
  description = "the vpc name"
  default = "terraform vpc"
}

variable "subnets-names" {
  type = list
  description = "names for the subnets"
  default = ["sub1", "sub2"]
}

variable "AZs" {
  type = list
  description = "the AZ you want to use"
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "ec2-image" {
   description = "the ec2 image 2 use"
}
variable "tags" {
  description = "defoult tags"
  type        = map(string)
  default = {
    owner           = "dvir-pashut"
    bootcamp        = "17"
    expiration_date = "01-04-23"
  }
}

variable "AZ" {
  description = "the first az to use"
  type        = list(any)
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

variable "subnets-name" {
  type        = list(any)
  description = "subnets name"
}


variable "vpc-name" {
  type        = string
  description = "vpc name"
}


variable "sub-count" {
  type        = number
  description = "how many subnets to make"
  default     = 2

  validation {
    condition     = var.sub-count == 1 || var.sub-count == 2
    error_message = "not valid number... enter 1 or 2"
  }
}
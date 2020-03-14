variable "vpc_cidr" {
  description = "The cidr range for vpc"
  type        = "string"
}

variable "public_subnet_a_cidr" {
  description = "The cidr range for public subnet a"
  type        = "string"
}

variable "public_subnet_b_cidr" {
  description = "The cidr range for public subnet b"
  type        = "string"
}

variable "private_subnet_a_cidr" {
  description = "The cidr range for private subnet a"
  type        = "string"
}

variable "private_subnet_b_cidr" {
  description = "The cidr range for private subnet b"
  type        = "string"
}



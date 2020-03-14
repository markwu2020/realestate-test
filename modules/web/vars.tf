variable "public_subnet_a" {
  description = "The public subnet a id"
  type        = "string"
}

variable "public_subnet_b" {
  description = "The public subnet b id"
  type        = "string"
}

variable "private_subnet_a" {
  description = "The private subnet a id"
  type        = "string"
}

variable "private_subnet_b" {
  description = "The private subnet b id"
  type        = "string"
}

variable "public_sg" {
  description = "The public security group id"
  type        = "string"
}

variable "private_sg" {
  description = "The private security group id"
  type        = "string"
}

variable "ssh_key_name" { 
  description = "The name for the SSH private key" 
}

 variable "private_key_path" {
   description     = "Path for the SSH private key"
 }

 variable "num_bastion_host" {
  description     = "Number of Bastion Host" 
 }

  variable "num_app" {
  description     = "Number of Web Application" 
 }

  variable "instance_type_bastion_host" {
  description     = "Instance type of Bastion Host" 
 }

  variable "instance_type_app" {
  description     = "Instance type of Web Application" 
 }
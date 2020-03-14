variable "env" {
  description = "The environment to deploy"
  type        = "string"
}

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

variable "multi_az" {
  description = "Create a replica in different zone if set to true"
}

variable "allocated_storage" {
  description = "The amount of allocated storage"
}

variable "skip_final_snapshot" {
  description = "Creates a snapshot when db is deleted if set to true"
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
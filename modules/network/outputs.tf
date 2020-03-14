output "main_vpc" {
  description = "The main vpc id"
  value       = "${aws_vpc.main_vpc.id}"
}

output "public_subnet_a" {
  description = "The public subnet a id"
  value       = "${aws_subnet.public_subnet_a.id}"
}

output "public_subnet_b" {
  description = "The public subnet b id"
  value       = "${aws_subnet.public_subnet_b.id}"
}

output "private_subnet_a" {
  description = "The private subnet a id"
  value       = "${aws_subnet.private_subnet_a.id}"
}

output "private_subnet_b" {
  description = "The private subnet b id"
  value       = "${aws_subnet.private_subnet_b.id}"
}


output "public_sg" {
  description = "The public security group id"
  value       = "${aws_security_group.public_sg.id}"
}

output "private_sg" {
  description = "The private security group id"
  value       = "${aws_security_group.private_sg.id}"
}

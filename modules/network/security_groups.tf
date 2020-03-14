# ------------------------------------------------------------------------------
# PUBLIC SECURITY GROUP
# ------------------------------------------------------------------------------

resource "aws_security_group" "public_sg" {
  name   = "public_sg"
  vpc_id = "${aws_vpc.main_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------------------------------------------------------
# PRIVATE SECURITY GROUP
# ------------------------------------------------------------------------------

resource "aws_security_group" "private_sg" {
  name   = "private_sg"
  vpc_id = "${aws_vpc.main_vpc.id}"

  # ingress {
  #   from_port = 80
  #   to_port   = 80
  #   protocol  = "tcp"
  #   self      = true
  # }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.public_sg.id}"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = ["${aws_security_group.public_sg.id}"]
  }

  # ingress {
  #   from_port = 8080
  #   to_port   = 8080
  #   protocol  = "tcp"
  #   self      = true
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

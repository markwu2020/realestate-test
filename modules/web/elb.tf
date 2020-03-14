# ---------------------------------------------------------------------------------------------------------------------
# ELB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_elb" "elb" {
  name            = "elb"
  security_groups = ["${var.private_sg}", "${var.public_sg}"]
  subnets         = ["${var.public_subnet_a}", "${var.public_subnet_b}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:3000/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 3000
    instance_protocol = "http"
  }

  instances           = ["${aws_instance.app[0].id}","${aws_instance.app[1].id}"]
  tags = {
    Name = "rea-tf-elb"
  }
}
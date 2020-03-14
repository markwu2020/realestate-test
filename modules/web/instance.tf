resource "aws_instance" "main" {
  count         = "${var.num_bastion_host}"
  ami           = "ami-02a599eb01e3b3c5b"
  instance_type = "${var.instance_type_bastion_host}"
  security_groups      = ["${var.public_sg}"]
  key_name = "${var.ssh_key_name}"
  subnet_id = "${element(list("${var.public_subnet_a}", "${var.public_subnet_b}"), count.index)}"

  provisioner "file" {
    source = "./${var.private_key_path}"
    destination = "/home/ubuntu/${var.private_key_path}"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${file(var.private_key_path)}"  
    }
  }
  tags = { 
    Name = "bastion-host-${count.index}"
  }
}

resource "aws_instance" "app" {
  count         = "${var.num_app}"
  ami           = "ami-02a599eb01e3b3c5b"
  instance_type = "${var.instance_type_app}"
  security_groups      = ["${var.private_sg}"]
  key_name = "${var.ssh_key_name}"
  user_data= "${file("deploy.sh")}"
  subnet_id = "${element(list("${var.private_subnet_a}", "${var.private_subnet_b}"), count.index)}"


  tags = { 
    Name = "web-app-${count.index}"
  }
}
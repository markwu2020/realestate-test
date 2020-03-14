# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region = "ap-southeast-2"
}

# ------------------------------------------------------------------------------
# RUNNING MODULES
# ------------------------------------------------------------------------------

module "network" {
  source                = "./modules/network"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_a_cidr  = "${var.public_subnet_a_cidr}"
  public_subnet_b_cidr  = "${var.public_subnet_b_cidr}"
  private_subnet_a_cidr = "${var.private_subnet_a_cidr}"
  private_subnet_b_cidr = "${var.private_subnet_b_cidr}"
}

module "web" {
  source            = "./modules/web"
  public_subnet_a   = "${module.network.public_subnet_a}"
  public_subnet_b   = "${module.network.public_subnet_b}"
  private_subnet_a  = "${module.network.private_subnet_a}"
  private_subnet_b  = "${module.network.private_subnet_b}"
  public_sg         = "${module.network.public_sg}"
  private_sg        = "${module.network.private_sg}"
  instance_type_bastion_host = "${var.instance_type_bastion_host}"
  instance_type_app = "${var.instance_type_app}"
  num_bastion_host  = "${var.num_bastion_host}"
  num_app           = "${var.num_app}"
  ssh_key_name      = "${var.ssh_key_name}"
  private_key_path  = "${var.private_key_path}"
}






# ------------------------------------------------------------------------------
# NAT GATEWAYS
# ------------------------------------------------------------------------------

resource "aws_eip" "nat_eip_a" {
  vpc        = true
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = "${aws_eip.nat_eip_a.id}"
  subnet_id     = "${aws_subnet.public_subnet_a.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

resource "aws_eip" "nat_eip_b" {
  vpc        = true
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id = "${aws_eip.nat_eip_b.id}"
  subnet_id     = "${aws_subnet.public_subnet_b.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

#--------------------------------------------------------------
# This module creates all resources necessary for NAT Gateway
#--------------------------------------------------------------

resource "aws_eip" "nat" {
  vpc   = true

  lifecycle { create_before_destroy = true }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(split(",", var.public_subnet_ids), count.index)}"

  lifecycle { create_before_destroy = true }
}

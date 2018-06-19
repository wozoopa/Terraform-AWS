#--------------------------------------------------------------
# This module creates all resources necessary for a private
# subnet
#--------------------------------------------------------------

resource "aws_subnet" "private" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(split(",", var.cidrs))}"

  tags      { Name = "${var.name}.${element(split(",", var.azs), count.index)}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_route_table" "private_through_nat_gateway" {
  count  = "${var.use_nat_gateway != "" ? 1 : 0 }"

  vpc_id = "${var.vpc_id}"
  count  = "${length(split(",", var.cidrs))}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(split(",", var.nat_gateway_ids), count.index)}"
  }

  tags      { Name = "${var.name}.${element(split(",", var.azs), count.index)}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_route_table" "private_through_nat_ec2" {
  count  = "${var.use_ec2_nat != "" ? 1 : 0 }"

  vpc_id = "${var.vpc_id}"
  count  = "${length(split(",", var.cidrs))}"

  route {
    cidr_block     = "0.0.0.0/0"
    instance_id = "${element(split(",", var.nat_instance_ids), count.index)}"
  }

  tags      { Name = "${var.name}.${element(split(",", var.azs), count.index)}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "private_through_nat_gateway" {
	count = "${var.use_nat_gateway != "" ? 1 : 0 }"
  
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_through_nat_gateway.*.id, count.index)}"

  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "private_through_nat_ec2" {
	count = "${var.use_ec2_nat != "" ? 1 : 0 }"
  
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_through_nat_ec2.*.id, count.index)}"

  lifecycle { create_before_destroy = true }
}

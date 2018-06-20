#--------------------------------------------------------------
# This module creates all resources necessary for a security
# group with unlimited access from On Premise networks.
#--------------------------------------------------------------

resource "aws_security_group" "all_to_op_sg" {
  name        = "${var.name}"
  description = "Allow all protocols on all ports to On Premise networks"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "all_to_op_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.all_to_op_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_to_op_rule" {
  count = "${length(var.source_ip_addresses) > 0 ? 1 : 0 }"

  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.all_to_op_sg.id}"
  cidr_blocks       = ["${var.source_ip_addresses}"]
}

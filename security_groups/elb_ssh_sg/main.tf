#--------------------------------------------------------------
# This module creates all resources necessary for a SSH ELB
#  Security Group.
#--------------------------------------------------------------

resource "aws_security_group" "elb_ssh_sg" {
  name        = "${var.name}"
  description = "SSH ELB Security Group."
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "elb_ssh_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.elb_ssh_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "elb_ssh_ingress1" {
  count = "${length(var.source_ssh_ip) > 0 ? 1 : 0 }"

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.elb_ssh_sg.id}"
  cidr_blocks       = ["${var.source_ssh_ip}"]
}

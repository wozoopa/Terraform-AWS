#--------------------------------------------------------------
# This module creates all resources for Bastion Security
# Group.
#--------------------------------------------------------------

resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}"
  description = "Bastion Security Group."
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "bastion_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.bastion_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh_bastion_ingress" {
  count = "${length(var.ssh_source_ip_into_bastion) > 0 ? 1 : 0 }"

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion_sg.id}"
  cidr_blocks              = ["${var.ssh_source_ip_into_bastion}"]
}

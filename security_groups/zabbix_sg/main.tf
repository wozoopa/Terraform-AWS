#-------------------------------------------------------------------------
# This module creates all resources necessary for a Zabbix Security Group
#-------------------------------------------------------------------------

resource "aws_security_group" "zabbix_sg" {
  name        = "${var.name}"
  description = "Allow all TCP traffic to ports 80 and 443"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "zabbix_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.zabbix_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rule1" {
  type                     = "ingress"
  from_port                = 10050
  to_port                  = 10050
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.zabbix_sg.id}"
  source_security_group_id = "${var.source_sg_id}"
}

resource "aws_security_group_rule" "rule2" {
  type                     = "ingress"
  from_port                = 10051
  to_port                  = 10051
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.zabbix_sg.id}"
  source_security_group_id = "${var.source_sg_id}"
}


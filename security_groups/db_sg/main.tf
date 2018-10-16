#--------------------------------------------------------------
# This module creates all resources necessary for RDS
# Security Group
#--------------------------------------------------------------

resource "aws_security_group" "rds_sg" {
  name        = "${var.name}"
  description = "Allow designated traffic to RDS on selected port "
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "rds_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.rds_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_rds_sg_rule" {
  type                     = "ingress"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rds_sg.id}"
  source_security_group_id = "${var.source_sg_id}"
}

#----------------------------------------------------------------------
# This module creates all resources necessary for a Web Security Group
#----------------------------------------------------------------------

resource "aws_security_group" "web_sg" {
  name        = "${var.name}"
  description = "Allow all TCP traffic to ports 80 and 443"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "web_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.web_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

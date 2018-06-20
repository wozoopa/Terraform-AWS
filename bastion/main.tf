#--------------------------------------------------------------
# This module creates all resources necessary for a Bastion
# host
#--------------------------------------------------------------

resource "aws_instance" "bastion" {
  ami                         = "${var.nat_ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${element(split(",", var.public_subnet_ids), count.index)}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.security_group_ids}"]
  associate_public_ip_address = true

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group" "ssh_from_bastion_sg" {
  name        = "${var.name}-SSH"
  description = "Allow SSH traffic from the bastion host"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "ssh_from_bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.ssh_from_bastion_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}


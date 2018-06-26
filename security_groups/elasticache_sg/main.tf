#------------------------------------------------------------------
# This module creates all resources necessary for a Elasticache SG 
#------------------------------------------------------------------

resource "aws_security_group" "elasticache_sg" {
  name        = "${var.name}"
  description = "Allow all TCP traffic to port 6379"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name      = "${var.name}"
    CreatedBy = "Terraform"
  }
}

resource "aws_security_group_rule" "elasticache_sg_egress" {
  type                     = "egress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elasticache_sg.id}"
  source_security_group_id = "${var.source_sg_id}"
}

resource "aws_security_group_rule" "elasticache_sg_ingress" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = "${var.source_sg_id}"
  security_group_id        = "${aws_security_group.elasticache_sg.id}"
}


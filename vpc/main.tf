#--------------------------------------------------------------
# This module creates all resources necessary for a VPC
#--------------------------------------------------------------


resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}


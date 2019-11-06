#--------------------------------------------------------------
# This module creates all resources necessary for a VPC
#--------------------------------------------------------------

resource "aws_vpc_dhcp_options" "internal_dhcp" {
    domain_name = "${var.domain}"

    tags {
        Name = "${var.domain}-DHCP"
    }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}

resource "aws_vpc_dhcp_options_association" "internal_domain" {
    vpc_id = "${aws_vpc.vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.internal_dhcp.id}"
}

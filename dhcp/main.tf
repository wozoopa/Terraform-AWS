#--------------------------------------------------------------
# This module creates all resources necessary for DHCP 
#--------------------------------------------------------------

resource "aws_vpc_dhcp_options" "internal_dhcp" {
    domain_name = "${var.domain}"

    tags {
        Name = "${var.domain}-DHCP"
    }
}

resource "aws_vpc_dhcp_options_association" "internal_domain" {
    vpc_id = "${var.vpc_id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.internal_dhcp.id}"
}

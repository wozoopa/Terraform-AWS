output "elb_id" {
  value = "${aws_elb.elb_tcp.id}"
}

output "elb_name" {
  value = "${aws_elb.elb_tcp.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb_tcp.dns_name}"
}

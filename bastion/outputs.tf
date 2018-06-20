output "private_ip" { value = "${aws_instance.bastion.private_ip}" }
output "public_ip"  { value = "${aws_instance.bastion.public_ip}" }
output "ssh_from_nat_sg_id" { value = "${aws_security_group.ssh_from_bastion_sg.id}" }
output "id" { value = "${aws_instance.bastion.id}" }

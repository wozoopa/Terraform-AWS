output "asg_id_no_ebs_no_template" {
  value = "${aws_autoscaling_group.main_asg_no_ebs_no_template.id}"
}

output "asg_id_no_ebs_with_template" {
  value = "${aws_autoscaling_group.main_asg_no_ebs_use_template.id}"
}

output "asg_id_use_ebs_no_template" {
  value = "${aws_autoscaling_group.main_asg_with_ebs_no_template.id}"
}

output "asg_id_use_ebs_with_template" {
  value = "${aws_autoscaling_group.main_asg_with_ebs_use_template.id}"
}



output "asg_name_no_ebs_no_template" {
  value = "${aws_autoscaling_group.main_asg_no_ebs_no_template.name}"
}

output "asg_name_no_ebs_use_template" {
  value = "${aws_autoscaling_group.main_asg_no_ebs_use_template.name}"
}

output "asg_name_with_ebs_no_template" {
  value = "${aws_autoscaling_group.main_asg_with_ebs_no_template.name}"
}

output "asg_name_with_ebs_use_template" {
  value = "${aws_autoscaling_group.main_asg_with_ebs_use_template.name}"
}


output "lc_id_no_ebs_no_template" {
   value = "${aws_launch_configuration.launch_config_no_ebs_no_template.id}"
}

output "lc_id_no_ebs_use_template" {
   value = "${aws_launch_configuration.launch_config_no_ebs_use_template.id}"
}

output "lc_id_with_ebs_no_template" {
   value = "${aws_launch_configuration.launch_config_with_ebs_no_template.id}"
}

output "lc_id_with_ebs_use_template" {
   value = "${aws_launch_configuration.launch_config_with_ebs_use_template.id}"
}



output "lc_name_no_ebs_no_template" {
   value = "${aws_launch_configuration.launch_config_no_ebs_no_template.name}"
}

output "lc_name_no_ebs_use_template" {
   value = "${aws_launch_configuration.launch_config_no_ebs_use_template.name}"
}

output "lc_name_with_ebs_no_template" {
   value = "${aws_launch_configuration.launch_config_with_ebs_no_template.name}"
}

output "lc_name_with_ebs_use_template" {
   value = "${aws_launch_configuration.launch_config_with_ebs_use_template.name}"
}


#output "ebs_id" {
#  value = "${aws_ebs_volume.ebs_volume.id}"
#}

#output "local_exec_output_one" {
#     value = "${null_resource.ec2_under_asg_id_no_ebs.result}"
#
##   provisioner "local-exec" {
##      command = "cat ${aws_autoscaling_group.main_asg.name}.instance_id.txt"
##   }
#
#}
#
#output "local_exec_output_two" {
#     value = "${null_resource.ec2_under_asg_id_with_ebs.result}"
#
##   provisioner "local-exec" {
##      command = "cat ${aws_autoscaling_group.main_asg.name}.instance_id.txt"
##   }
#
#}

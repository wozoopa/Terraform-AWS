data "template_file" "user_data" {
   count = "${var.use_template_file ? 1 : 0}"

   template = "${var.user_data_path}"
}



resource "aws_launch_configuration" "launch_config_no_ebs_no_template" { # No EBS & no template
  count                       = "${var.donot_attach_ebs * var.donot_use_template_file}"

  name_prefix                 = "${var.lc_name}"
  image_id                    = "${var.lc_ami_id}"
  instance_type               = "${var.lc_instance_type}"
  security_groups             = ["${var.lc_security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.instance_iam_role}"

  user_data                   = "cluster_name=${var.cluster_name}\nEBS_VOLUME_ID=${var.ebs_id}\nVolumeSize=${var.volume_size}\nVolumeType=${var.volume_type}\nNODE_NAME=${var.node_name}#\nADMIN_USERNAME=${var.admin_username}\nADMIN_PASSWORD=${var.admin_pass}\nCLUSTER_MASTER=${var.cluster_master}\nLICENSEE=${var.licensee}\nLICENSE_KEY=${var.license_key}\nLOG_SNS=${var.log_sns}\n"

  #lifecycle {
  #  create_before_destroy = "${var.enable_lc_lifecycle}"
  #}
}

resource "aws_launch_configuration" "launch_config_no_ebs_use_template" { # No ebs but use template file
  count                       = "${var.donot_attach_ebs * var.use_template_file}"

  name_prefix                 = "${var.lc_name}"
  image_id                    = "${var.lc_ami_id}"
  instance_type               = "${var.lc_instance_type}"
  security_groups             = ["${var.lc_security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.instance_iam_role}"

  user_data                   = "${data.template_file.user_data.rendered}"

  #lifecycle {
  #  create_before_destroy = "${var.enable_lc_lifecycle}"
  #}
}


resource "aws_launch_configuration" "launch_config_with_ebs_no_template" { # add EBS & no template
  count                       = "${var.attach_ebs * var.donot_use_template_file}"

  name_prefix                 = "${var.lc_name}"
  image_id                    = "${var.lc_ami_id}"
  instance_type               = "${var.lc_instance_type}"
  security_groups             = ["${var.lc_security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.instance_iam_role}"

  user_data                   = "CLUSTER_NAME=${var.cluster_name}\nEBS_VOLUME=${var.ebs_id}\nVolumeSize=${var.volume_size}\nVolumeType=${var.volume_type}\nNODE_NAME=${var.node_name}#\nADMIN_USERNAME=${var.admin_username}\nADMIN_PASSWORD=${var.admin_pass}\nCLUSTER_MASTER=${var.cluster_master}\nLICENSEE=${var.licensee}\nLICENSE_KEY=${var.license_key}\nLOG_SNS=${var.log_sns}\n"

  #lifecycle {
  #  create_before_destroy = "${var.enable_lc_lifecycle}"
  #}

  # EBS configuration
  #
  ebs_block_device {
     device_name           = "${var.ebs_letter}"
     snapshot_id           = "${var.ebs_snapshot_id}"
     volume_type           = "${var.ebs_type}"
     volume_size           = "${var.ebs_size}"
     delete_on_termination = "${var.ebs_delete_on_termination}"
     encrypted             = "${var.encrypted}"
  }
}


resource "aws_launch_configuration" "launch_config_with_ebs_use_template" { # add EBS & use template
  count                       = "${var.attach_ebs * var.use_template_file}"

  name_prefix                 = "${var.lc_name}"
  image_id                    = "${var.lc_ami_id}"
  instance_type               = "${var.lc_instance_type}"
  security_groups             = ["${var.lc_security_groups}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.instance_iam_role}"

  user_data                   = "${data.template_file.user_data.rendered}"

  #lifecycle {
  #  create_before_destroy = "${var.enable_lc_lifecycle}"
  #}

  # EBS configuration
  #
  ebs_block_device {
     device_name           = "${var.ebs_letter}"
     snapshot_id           = "${var.ebs_snapshot_id}"
     volume_type           = "${var.ebs_type}"
     volume_size           = "${var.ebs_size}"
     delete_on_termination = "${var.ebs_delete_on_termination}"
     encrypted             = "${var.encrypted}"
  }
}


resource "aws_autoscaling_group" "main_asg_no_ebs_no_template" {
  count      = "${var.donot_attach_ebs * var.donot_use_template_file}"

  depends_on = ["aws_launch_configuration.launch_config_no_ebs_no_template"]
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config_no_ebs_no_template.name}"


  #// Split out the AZs string into an array
  #// The chosen availability zones *must* match
  #// the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.asg_azs)}"]

  // Split out the subnets string into an array
  vpc_zone_identifier = ["${element(var.subnets, var.subnet_index)}"]



  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config_no_ebs_no_template.id}"

  max_size                  = "${var.NodesPerZone}"
  desired_capacity          = "${var.NodesPerZone}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  default_cooldown          = "${var.default_cooldown}"

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = "false"
  #  ignore_changes = [ "volume" ]
  }
}



resource "aws_autoscaling_group" "main_asg_no_ebs_use_template" {
  count      = "${var.donot_attach_ebs * var.use_template_file}"

  depends_on = ["aws_launch_configuration.launch_config_no_ebs_use_template"]
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config_no_ebs_use_template.name}"


  #// Split out the AZs string into an array
  #// The chosen availability zones *must* match
  #// the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.asg_azs)}"]

  // Split out the subnets string into an array
  vpc_zone_identifier = ["${element(var.subnets, var.subnet_index)}"]



  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config_no_ebs_use_template.id}"

  max_size                  = "${var.NodesPerZone}"
  desired_capacity          = "${var.NodesPerZone}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  default_cooldown          = "${var.default_cooldown}"

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = "false"
  #  ignore_changes = [ "volume" ]
  }
}



resource "aws_autoscaling_group" "main_asg_with_ebs_no_template" {
  count      = "${var.attach_ebs * var.donot_use_template_file}"

  depends_on = ["aws_launch_configuration.launch_config_with_ebs_no_template"]
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config_with_ebs_no_template.name}"


  #// Split out the AZs string into an array
  #// The chosen availability zones *must* match
  #// the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.asg_azs)}"]

  // Split out the subnets string into an array
  vpc_zone_identifier = ["${element(var.subnets, var.subnet_index)}"]



  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config_with_ebs_no_template.id}"

  max_size                  = "${var.NodesPerZone}"
  desired_capacity          = "${var.NodesPerZone}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  default_cooldown          = "${var.default_cooldown}"

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = "false"
  #  ignore_changes = [ "volume" ]
  }
}



resource "aws_autoscaling_group" "main_asg_with_ebs_use_template" {
  count      = "${var.attach_ebs * var.use_template_file}"

  depends_on = ["aws_launch_configuration.launch_config_with_ebs_use_template"]
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config_with_ebs_use_template.name}"


  #// Split out the AZs string into an array
  #// The chosen availability zones *must* match
  #// the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.asg_azs)}"]

  // Split out the subnets string into an array
  vpc_zone_identifier = ["${element(var.subnets, var.subnet_index)}"]



  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config_with_ebs_use_template.id}"

  max_size                  = "${var.NodesPerZone}"
  desired_capacity          = "${var.NodesPerZone}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  load_balancers            = ["${var.load_balancers}"]
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  default_cooldown          = "${var.default_cooldown}"

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = "false"
  #  ignore_changes = [ "volume" ]
  }
}


resource "aws_autoscaling_notification" "ServerGroup_notifications_no_ebs_no_template" {
  count  = "${var.donot_attach_ebs * var.donot_use_template_file}"

  group_names = [
    "${aws_autoscaling_group.main_asg_no_ebs_no_template.name}"
  ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
  topic_arn = "${var.log_sns}"
}


resource "aws_autoscaling_notification" "ServerGroup_notifications_no_ebs_use_template" {
   count = "${var.donot_attach_ebs * var.use_template_file}"

  group_names = [
    "${aws_autoscaling_group.main_asg_no_ebs_use_template.name}"
  ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
  topic_arn = "${var.log_sns}"
}


resource "aws_autoscaling_notification" "ServerGroup_notifications_with_ebs_no_template" {
   count = "${var.attach_ebs * var.donot_use_template_file}"

  group_names = [
    "${aws_autoscaling_group.main_asg_with_ebs_no_template.name}"
  ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
  topic_arn = "${var.log_sns}"
}


resource "aws_autoscaling_notification" "ServerGroup_notifications_with_ebs_use_template" {
   count = "${var.attach_ebs * var.use_template_file}"

  group_names = [
    "${aws_autoscaling_group.main_asg_with_ebs_use_template.name}"
  ]
  notifications  = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
  topic_arn = "${var.log_sns}"
}

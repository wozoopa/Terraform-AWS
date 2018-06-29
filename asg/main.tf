resource "aws_launch_configuration" "launch_config" {
  name_prefix     = "${var.lc_name}"
  image_id        = "${var.asg_ami_id}"
  instance_type   = "${var.asg_instance_type}"
  security_groups = ["${var.asg_security_groups}"]
  user_data       = "${var.asg_user_data}"
  key_name        = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config.name}"

  # Split out the AZs string into an array
  # The chosen availability zones *must* match
  # the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.asg_azs)}"]

  # Split out the subnets string into an array
  vpc_zone_identifier = ["${split(",", var.asg_subnets)}"]

  # Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  load_balancers            = ["${var.load_balancers}"]
  desired_capacity          = "${var.asg_number_of_instances}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

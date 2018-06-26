resource "aws_elb" "elb_tcp" {
  name            = "${var.elb_name}"
  subnets         = ["${split(",", var.elb_subnets)}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${split(",", var.elb_security_groups)}"]
  idle_timeout    = "${var.idle_timeout}"

  listener {
    instance_port     = "${var.instance_port_for_listener}"
    instance_protocol = "tcp"
    lb_port           = "${var.lb_port_for_listener}"
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    timeout             = "${var.health_check_timeout}"
    target              = "${var.health_check_target}"
    interval            = "${var.health_check_interval}"
  }

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  tags {
    Name = "${var.elb_name}"
  }

}


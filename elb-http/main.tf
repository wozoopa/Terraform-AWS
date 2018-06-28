resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${split(",", var.elb_subnets)}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${split(",", var.elb_security_groups)}"]
  idle_timeout    = "${var.idle_timeout}"

  listener {
    instance_port     = "${var.elb_backend_port}"
    instance_protocol = "${var.elb_backend_protocol}"
    lb_port           = "${var.lb_port_for_listener}"
    lb_protocol       = "http"
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

resource "aws_lb_cookie_stickiness_policy" "elb_stickiness" {
  name                     = "${var.elb_name}-Stickiness"
  load_balancer            = "${aws_elb.elb.id}"
  lb_port                  = 80
  cookie_expiration_period = "${var.stickiness_expiration}"
  depends_on               = [ "aws_elb.elb" ]
}

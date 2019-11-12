```ELB example```
# requires ssl to be created


resource "aws_elb" "elb_https" {
  name            = "${var.name}-ELB"
  security_groups = ["${module.web_sg.web_sg_id}"]
  subnets         = ["${split(",", module.public_subnet.subnet_ids)}"]
  idle_timeout    = 1200

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${lookup(var.ssl_cert_arn, var.region)}"
  }

  health_check {
    unhealthy_threshold = 2
    healthy_threshold   = 5
    timeout             = 60
    interval            = 90
    target              = "HTTP:80/home"
  }

  cross_zone_load_balancing = true

  tags {
    Name        = "${var.name}-ELB"
    Application = "${var.domain}"
    Environment = "${lookup(var.environment, var.region)}"
  }
}

resource "aws_lb_cookie_stickiness_policy" "stickiness1" {
  depends_on               = ["aws_elb.elb_https"]
  name                     = "http-policy"
  load_balancer            = "${aws_elb.elb_https.id}"
  lb_port                  = 80
  cookie_expiration_period = 7200
}


resource "aws_lb_cookie_stickiness_policy" "stickiness2" {
  depends_on               = ["aws_elb.elb_https"]
  name                     = "https-policy"
  load_balancer            = "${aws_elb.elb_https.id}"
  lb_port                  = 443
  cookie_expiration_period = 7200
}

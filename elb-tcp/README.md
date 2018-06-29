elb_tcp
========
A Terraform module for creating an ELB that listens on selected port

Input Variables
---------------
- `elb_name` - A name to give the ELB, to show up in the console
- `elb_is_internal` - Whether this ELB is internal, default is *false*
- `elb_security_groups` - A list of security group IDs to which the ELB should belong
- `idle_timeout` - The time in seconds that the connection is allowed to be idle. Default is *1200*
- `instance_port_for_listener` - The port on the instance to route to.
- `lb_port_for_listener` - The port to listen on for the load balancer.
- `health_check_healthy_threshold` - Default is *3*
- `health_check_unhealthy_threshold` - Default is *5*
- `health_check_timeout` - Default is *5*
- `health_check_target` - The target of the check.
- `health_check_interval` - Default is *10*
- `cross_zone_load_balancing` -  Default is *true*.
- `connection_draining` - ### .. Default is *true*.
- `connection_draining_timeout` -  Default is *60*.
- `elb_subnets` - A list of all subnets to attach to the ELB
- `elb_health_check_target` - The URL the ELB should use for health checks; the format is *TCP:22*
- `stickiness_expiration` - The duration, in seconds, of the stickiness cookie expiration; default is *7200*

Outputs
-------
- `elb_id` - The ELB identifier
- `elb_name` - The name of the elb
- `elb_dns_name` - The DNS name (A record) of the ELB

Usage
-----
You can use this in your Terraform templates with the following steps:

1.) Add a module resource to your template, e.g. `main.tf`
```
module "ssh-elb-tcp" {
  source        = "git::https://github.com/wozoopa/aws//elb_tcp"

  elb_name                   = "${var.name}-${lookup(var.environment, var.region)}-SSH-ELB-TCP"
  elb_security_groups        = "${module.ssh_elb_sg.sg_id}"
  instance_port_for_listener = "22"
  lb_port_for_listener       = "22"
  health_check_target        = "TCP:22"
  elb_subnets                = "${module.public_subnet.subnet_ids}"
}
```


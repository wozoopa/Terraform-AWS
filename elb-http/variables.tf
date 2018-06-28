variable "elb_name" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}
variable "elb_security_groups" {}

variable "idle_timeout" {
  default = "1200"
}

variable "elb_backend_port" {}

variable "elb_backend_protocol" {}

variable "lb_port_for_listener" {}

variable "health_check_healthy_threshold" {
  default = "2"
}

variable "health_check_unhealthy_threshold" {
  default = "2"
}

variable "health_check_timeout" {
  default = "3"
}
  
variable "health_check_target" {
  description = "The URL the ELB should use for health checks"
}

variable "health_check_interval" {
  default = "10"
}

variable "cross_zone_load_balancing" {
  default = "true"
}

variable "connection_draining" {
  default = "true"
}

variable "connection_draining_timeout" {
  default = "60"
}

variable "elb_subnets" {
  description = "A list of all subnets to attach to the ELB"
}

variable "stickiness_expiration" {
  default = "7200"
}

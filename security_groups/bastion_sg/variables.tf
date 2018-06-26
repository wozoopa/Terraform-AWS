variable "name" {
  default = "BastionSG"
}

variable "vpc_id" { }
variable "ssh_source_ip_into_bastion" {
  type = "list"
}


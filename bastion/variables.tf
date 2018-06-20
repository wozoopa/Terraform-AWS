variable "name" {
  default = "bastion"
}

variable "vpc_id" {}

variable "public_subnet_ids" {}

variable "security_group_ids" {
  type = "list"
}

variable "nat_ami" {}

variable "key_name" {}

variable "instance_type" {
  default = "t2.small"
}

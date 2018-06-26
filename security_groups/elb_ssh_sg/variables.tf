variable "name" {
  default = "SSH_ELB_SG"
} 

variable "vpc_id" { }
variable "source_security_group_id" { }
variable "source_ssh_ip" {
  type = "list"
}

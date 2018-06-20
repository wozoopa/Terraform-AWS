variable "name" {
  default = "AllToOnPremise"
}

variable "vpc_id" { }
variable "source_ip_addresses" {
  type = "list"
}

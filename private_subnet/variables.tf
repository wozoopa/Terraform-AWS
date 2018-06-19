variable "name"                  { default = "private"}
variable "vpc_id"                { }
variable "cidrs"                 { }
variable "azs"                   { }
variable "nat_gateway_ids"       { default = "" }
variable "use_ec2_nat"           { default = "" }
variable "use_nat_gateway"       { default = "" }
variable "nat_instance_ids"      { default = "" }

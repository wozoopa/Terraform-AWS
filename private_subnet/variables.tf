variable "name"                  { default = "private"}
variable "vpc_id"                { }
variable "cidrs"                 { }
variable "azs"                   { }
variable "nat_gateway_ids"       { }
variable "use_ec2_nat"           { }
variable "use_nat_gateway"       { }
variable "nat_instance_ids"      { default = "" }

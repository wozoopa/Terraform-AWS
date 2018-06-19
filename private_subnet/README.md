private_subnet
==============



Usage
-----

`Example of using private_subnet with NAT Gateway:`

```
module "nat" {
  source = "git::https://github.com/wozoopa/aws.git//nat-gateway"

  name              = "${var.name}-nat"
  azs               = "${lookup(var.azs, var.region)}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
}

module "private_subnet" {
  source = "git::https://github.com/wozoopa/aws.git//private_subnet"

  name                  = "${var.name}-private"
  vpc_id                = "${module.vpc.vpc_id}"
  cidrs                 = "${lookup(var.private_subnets, var.region)}"
  azs                   = "${lookup(var.azs, var.region)}"
  use_nat_gateway       = "true"

  nat_gateway_ids = "${module.nat.nat_gateway_ids}"
  nat_instance_ids = ""
}
```


`Example of using private_subnet with Bastion host:`
```
module "private_subnet" {
  source = "git::https://github.com/wozoopa/aws.git//private_subnet"

  name                  = "${var.name}-private"
  vpc_id                = "${module.vpc.vpc_id}"
  cidrs                 = "${lookup(var.private_subnets, var.region)}"
  azs                   = "${lookup(var.azs, var.region)}"
  use_ec2_nat           = "true"

  nat_instance_ids = "${module.bastion.id}"
}
```

nat_gateway
===========
A Terraform module for creating an NAT gateway within a VPC.

Input Variables
---------------
- `name` - The VPC or application name, defaults to *nat*
- `azs` - The availability zones that can access this gateway
- `public_subnet_ids` - Public subnet IDs to be used by this gateway

Outputs
-------
- `nat_gateway_ids` - The AWS IDs of the NAT gateways

Usage
-----
You can use this in your Terraform templates with the following steps:

1.) Add a module resource to your template, e.g. `main.tf`
```
module "nat" {
  source = "git::https://github.com/wozoopa/aws.git//nat-gateway"

  name              = "${var.name}-nat"
  azs               = "${lookup(var.azs, var.region)}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
}
```



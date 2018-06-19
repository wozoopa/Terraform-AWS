public_subnet
=============


Usage
-----

```
module "public_subnet" {
  source = "git::https://github.com/wozoopa/aws.git//public_subnet"

  name   = "${var.name}-public"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${lookup(var.public_subnets, var.region)}"
  azs    = "${lookup(var.azs, var.region)}"
}
```

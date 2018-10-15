internet-gateway
=============

Input Variables
---------------
name
vpc_id


Outputs
-------
id - The ID of the Internet Gateway. 



Usage
-----

```
module "ig" {
  source = "git::https://github.com/wozoopa/aws//internet-gateway"

  name   = "${var.name}-ig"
  vpc_id = "${module.vpc.vpc_id}"
}
```

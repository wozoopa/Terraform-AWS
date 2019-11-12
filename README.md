# Terraform for AWS

```
├── asg
├── bastion
├── elb-http
├── elb-tcp
├── iam_user
├── nat-gateway
├── private_subnet
├── public_subnet
├── security_groups
│   ├── db_sg
│   ├── on_premise
│   └── web_sg
├── sns
└── vpc
```



# Example project:


``` file main.tf ```

terraform {
  required_version = "= 0.11.14"
}

module "vpc" {
  source = "git::https://vpc"

  name   = "${var.name}-VPC"
  cidr   = "${lookup(var.vpc_cidr, var.region)}"
  region = "${var.region}"
}

module "public_subnet" {
  source = "git::https://public-subnet"

  name   = "${var.name}-public"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${lookup(var.public_subnets, var.region)}"
  azs    = "${lookup(var.azs, var.region)}"
}

module "private_subnet" {
  source = "git::https://private-subnet"

  name   = "${var.name}-private"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${lookup(var.private_subnets, var.region)}"
  azs    = "${lookup(var.azs, var.region)}"

  nat_gateway_ids = "${module.nat.nat_gateway_ids}"
}

module "all_to_me_sg" {
  source = "git::https://all_to_me_sg"
  name   = "${var.name}-AllToME"
  vpc_id = "${module.vpc.vpc_id}"
}

module "web_sg" {
  source = "git::https://web_sg"
  name   = "${var.name}-WebSG"
  vpc_id = "${module.vpc.vpc_id}"
}

module "bastion" {
  source             = "git::bastion-host"
  name               = "${var.name}-Bastion"
  vpc_id             = "${module.vpc.vpc_id}"
  public_subnet_ids  = "${module.public_subnet.subnet_ids}"
  key_name           = "${var.ssh_key_name}"
  security_group_ids = ["${module.all_to_me_sg.id}", "${module.bastion.d}"]
  nat_ami            = "${lookup(var.nat_ami, var.region)}"
  instance_type      = "t2.medium"
}

module "nat" {
  source = "git::https://nat-gateway"

  name              = "${var.name}-nat"
  azs               = "${lookup(var.azs, var.region)}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
}


module "apache_asg" {
  source                          = "git::https://asg"
  name                            = "${var.name}-EC2"
  asg_name                        = "${var.name}-ASG"
  key_name                        = "${var.ssh_key_name}"
  lc_name                         = "${var.name}-LC"
  asg_ami_id                      = "${lookup(var.apache_ami, var.region)}"
  asg_instance_type               = "${lookup(var.apache_instance_type, var.region)}"
  asg_security_groups             = ["${module.web_sg.id}", "${module.bastion.id}"]
  asg_number_of_instances         = "${lookup(var.min_instances_in_asg, var.region)}"
  asg_minimum_number_of_instances = "${lookup(var.max_instances_in_asg, var.region)}"
  asg_subnets                     = "${module.private_subnet.subnet_ids}"
  asg_user_data                   = "${file("userdata.sh.${lookup(var.environment, var.region)}")}"
  asg_azs                         = "${lookup(var.azs, var.region)}"
  load_balancers                  = ["${aws_elb.elb_https.id}"]
  instance_iam_role               = "ApacheEC2InstanceProfile-${var.environment}"
}




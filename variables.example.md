variable "name" {
  default = "Application1"
}

variable "environment" {
  default {
    us-east-1 = "development"
    us-west-1 = "staging"
    us-west-2 = "production"
  }
}

variable "environment_abbreviated" {
  default {
    us-east-1 = "dev"
    us-west-1 = "stg"
    us-west-2 = "prd"
  }
}

variable "azs" {
  default {
    us-east-1 = "us-east-1a,us-east-1b,us-east-1c"
    us-west-1 = "us-west-1a,us-west-1b,us-west-1c"
    us-west-2 = "us-west-2a,us-west-2b,us-west-2c"
  }
}

provider "aws" {
  region = "us-west-2"
}

# AWS Region
variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default {
    us-east-1 = "172.200.0.0/16"
    us-west-1 = "172.210.0.0/16"
    us-west-2 = "172.220.0.0/16"
  }
}

variable "private_subnets" {
  default {
    us-east-1 = "172.200.1.0/24,172.200.3.0/24,172.200.5.0/24"
    us-west-1 = "172.210.1.0/24,172.210.3.0/24,172.210.5.0/24"
    us-west-2 = "172.220.1.0/24,172.220.3.0/24,172.220.5.0/24"
  }
}

variable "public_subnets" {
  default {
    us-east-1 = "172.200.0.0/24,172.200.2.0/24,172.200.4.0/24"
    us-west-1 = "172.210.0.0/24,172.210.2.0/24,172.210.4.0/24"
    us-west-2 = "172.220.0.0/24,172.220.2.0/24,172.220.4.0/24"
  }
}

variable "subnet1" {
  default = {
    "us-east-1" = "subnet-<id>"
    "us-west-1" = ""
    "us-west-2" = ""
  }
}

variable "apache1_ami" {
  default = {
    "us-east-1" = "ami-<id>"
    "us-west-1" = ""
    "us-west-2" = "ami-<id>"
  }
}

variable "nat_ami" {
  default = {
    "us-east-1" = "ami-<id>"
    "us-west-1" = ""
    "us-west-2" = "ami-<id>"
  }
}

variable "apache_instance_type" {
  default = {
    "us-east-1" = "t2.large"
    "us-west-1" = "t2.medium"
    "us-west-2" = "t2.large"
  }
}

# SSH key to deploy
variable "key_name" {
  description = "Key pair to use"
  default     = "<key-name>"
}

# Whitelist your IP for SSH access here
variable "ip_whitelist" {
  description = "Whitelisted IP for SSH access"
  default     = "<some-ip>/32"
}

variable "min_instances_in_asg" {
  description = "Desired number of instances in the ASG"

  default = {
    "us-east-1" = 2
    "us-west-1" = 2
    "us-west-2" = 10
  }
}

variable "ssl_cert_arn" {
  default {
    us-east-1 = "<ssl-arn>"
    us-west-1 = ""
    us-west-2 = "<ssl-arn>"
  }
}


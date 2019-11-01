variable "load_balancers" {
  type = "list"
}

variable "region" { }

variable "asg_name" { }

variable "NodesPerZone" { }

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1

  // Defaults to 1
  // Can be set to 0 if you never want the ASG to replace failed instances
}

variable "asg_health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "asg_health_check_type" {
  default = "EC2"

  //Types available are:
  // - ELB
  // - EC2
  // * http://docs.aws.amazon.com/cli/latest/reference/autoscaling/create-auto-scaling-group.html#options
}

variable "asg_subnets" {
  description = "The VPC subnet IDs"

  // comma separated list
}

variable "asg_azs" {
  description = "Availability Zones"

  // comma separated list
}

variable "default_cooldown" { }
variable "subnet_index" { }
variable "subnets" {
   type = "list"
}

# - Launch Configuration:

variable "volume_type" { }
variable "lc_name" { }
variable "lc_ami_id" { }
variable "lc_instance_type" { }
variable "lc_security_groups" {
   type = "list"
}

variable "associate_public_ip_address" { }
variable "key_name" { }
variable "instance_iam_role" { }


# -  UserData variables:
variable "cluster_name" { }
variable "volume_size" { }
variable "admin_username" { }
variable "admin_pass" { }
variable "cluster_master" { }
variable "licensee" { }
variable "license_key" { }
variable "log_sns" { }
variable "ebs_id" { }
variable "node_name" { }
variable "attach_ebs" { }
variable "donot_attach_ebs" { }
variable "ebs_letter" { }
variable "ebs_snapshot_id" { }
variable "ebs_type" { }
variable "ebs_size" { }
variable "ebs_delete_on_termination" { }
variable "encrypted" { }
variable "use_template_file" { }
variable "donot_use_template_file" { }
variable "user_data_path" { }

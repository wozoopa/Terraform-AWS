ebs
===
A Terraform module for creating an Elastic Block Storage.

Input Variables
---------------
- `volume_name` - Application name that will be applied to instances in the ASG
- `volumeSize` -  The size of the drive in GiBs.
- `volume_snapshot_id` -  A snapshot to base the EBS volume off of.
- `volume_type` - The type of EBS volume. Can be "standard", "gp2", "io1", "sc1" or "st1" (Default: "standard").
- `volume_az` -  (Required) The AZ where the EBS volume will exist. Must match target ec2 instance.
- `iops ` - The amount of IOPS to provision for the disk.


# Add case if encrypted (count usage)
- `encrypted` - If true, the disk will be encrypted. Valid entries are: 0 (true) or 1 (false).
- `kms_key_id` - The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true.


Outputs
-------
- `id` - The volume ID
- `arn` - The volume ARN

Usage
-----
You can use this in your Terraform templates with the following steps:

1.) Add a module resource to your template, e.g. `main.tf`
```
module "ebs" {
  source                          = "git::https://github.com/wozoopa/aws.git//ebs"

  volume_name                     = "test-ec2-F"
  volumeSize                      = "100"
  volume_snapshot_id              = "snap-abce123"
  volume_type                     = "gp2"
  volume_az                       = "us-east-1a"
}

module "encrypted_ebs" {
  source                          = "git::https://github.com/wozoopa/aws.git//ebs"

  encrypt_drive                   = "0"
  kms_key_id                      = ""
  volume_name                     = "test-ec2-F"
  volumeSize                      = "100"
  volume_snapshot_id              = "snap-abce123"
  volume_type                     = "gp2"
  volume_az                       = "us-east-1a"
}


```

2.) Setting the input variables, either through `terraform.tfvars` or `-var` arguments on the CLI

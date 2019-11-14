tf-account_id
============
A Terraform module for getting AWS Account ID

Input Variables
---------------


Outputs
-------

- `id` - Displays current AWS Account ID used by terraform

Usage
-----
You can use this in your Terraform templates with the following steps:

1.) Add a module resource to your template, e.g. `main.tf`
```
module "tf-account-id" {
   source = "git::https://github.com/wozoopa/aws//tf-account-id"
}



```

2.) Setting the input variables, either through `terraform.tfvars` or `-var` arguments on the CLI


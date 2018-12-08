# List of few rules to follow from working with Terraform since version 0.6x up to 0.11.8.
### List is being updated every few months as things change.

1. Store executables in:

  `~/bin/terraform-<version>`
  
2. Always use latest version of Terraform for new project.
3. One off resources should be in `<logical-name>.tf`, for example:

  ```
  <vendor-name>_sg.tf
  ```
  
  and NOT added to modules.
  
  
4. Makefile, README should always be included.
5. All code should be versioned, even when working locally.
6. Standards for backend.tf

```
 terraform {
  required_version =">=<tf-version-used>"
  
  backend "s3" {
    bucket = "<bucket-name>-terraform-states"
    key = "<app-name-or-project>"/<environment>/terraform.state"
    region = "bucket-region"
    }
  }
  
  provider "aws" {
    region = "${var.region}"
    }
```
7. GIT branch = environment
8. Standards for TF code (base for every project - core resources):
   - a. main.tf:
     - Create VPC, public_subnet, private_subnet, nat, bastion 
   - b. variables.tf 
     - variable "region" {}
     - vpc_cidr
     - AZS
     - public_subnets
     - private_subnets
   - c. <project/app-name>.tf:
     - rest of resources
     
9. When writing modules write variables for every supported parameter (if time allows it). This saves time later when reusing modules in different projects.

10. Plan maintenance at least once a year to update architecture to the latest TF version.

11. Always look for ways on how to improve your code.   

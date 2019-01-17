terraform {
 required_version =">=0.11.8"

 backend "s3" {
   bucket = "<BUCKET-NAME>"
   dynamodb_table = "terraform-state-lock-dynamo"
   key = "<PATH-TO-STATE-FILE>/terraform.state"
   region = "<BUCKET-REGION>"
   encrypt = "true"
   }
 }


provider "aws" {
   region = "${var.region}"
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

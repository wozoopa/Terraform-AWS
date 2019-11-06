variable "volumeSize" { }
variable "volume_snapshot_id" { }
variable "volume_type" { }
variable "volume_name" { }

variable "tags" {
  default = {
    created_by = "Terraform"
  }
}
variable "volume_az" { }
variable "iops" { }
variable "encrypted" { }
variable "kms_key_id" { default = "" }
variable "encrypt_drive" { }

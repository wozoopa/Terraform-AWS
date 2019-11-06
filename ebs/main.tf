resource "aws_ebs_volume" "ebs_volume" {

  size              = "${var.volumeSize}"
  availability_zone = "${var.volume_az}"

  snapshot_id       = "${var.volume_snapshot_id}"
  type              = "${var.volume_type}"

  tags {
    CreatedBy  = "${lookup(var.tags,"created_by")}"
    Name       = "${var.volume_name}"
  }

}

resource "aws_ebs_volume" "encrypted_ebs_volume" {

  count             = "${var.encrypt_drive ? 1 : 0}"
  size              = "${var.volumeSize}"
  availability_zone = "${var.volume_az}"

  snapshot_id       = "${var.volume_snapshot_id}"
  type              = "${var.volume_type}"
  kms_key_id        = "${var.kms_key_id}"
  encrypted         = "${var.encrypted}" 

  tags {
    CreatedBy  = "${lookup(var.tags,"created_by")}"
    Name       = "${var.volume_name}"
  }

}

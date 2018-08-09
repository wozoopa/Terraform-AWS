# true = 1
# false = 0

resource "aws_iam_user" "iam_user_no_key_no_console" {
  name = "${var.username}"
  count = "${var.no_key_no_console ? 1 : 0}"

}

resource "aws_iam_user" "iam_user_with_key_no_console" {
  name = "${var.username}"
  count = "${var.enable_access_key_no_console ? 1 : 0}"

  provisioner "local-exec" {
    command = "aws iam create-access-key --user-name ${var.username}"
  }
}

resource "aws_iam_user" "iam_user_with_console_no_key" {
  name = "${var.username}"
  count = "${var.enable_console_no_key ? 1 : 0}"

  provisioner "local-exec" {
    command = "aws iam create-login-profile --user-name ${var.username} --password ${var.temp_pass} --password-reset-required"
  }
}

resource "aws_iam_user" "iam_user_with_console_with_key" {
  name = "${var.username}"
  count = "${var.enable_console_enable_key ? 1 : 0}"

  provisioner "local-exec" {
    command = "aws iam create-login-profile --user-name ${var.username} --password ${var.temp_pass} --password-reset-required"
  }
  provisioner "local-exec" {
    command = "aws iam create-access-key --user-name ${var.username}"
  }
}


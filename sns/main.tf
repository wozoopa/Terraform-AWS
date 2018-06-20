resource "aws_sns_topic" "sns_topic" {
    name = "${var.topic_name}"

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.sns_sub_email} --region ${var.region} "
  }

}

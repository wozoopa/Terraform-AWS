output "sns_topic_id" {
      value = "${aws_sns_topic.sns_topic.id}"
}

output "sns_subscription_email" {
      value = "${var.sns_sub_email}"
}

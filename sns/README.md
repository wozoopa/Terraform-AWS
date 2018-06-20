sns
===


Input Variables
---------------
- `region`
- `key_name`
- `topic_name`
- `sns_sub_email`

Outputs
-------
- `sns_topic_id`
- `sns_subscription_email`

Usage
-----

module "sns" {
  source        = "git::https://github.com/wozoopa/aws//sns"

  region        = "${var.region}"
  key_name      = "${var.key_name}"
  topic_name    = "NotifyMe"
  sns_sub_email = "<someone>@<domain.com>"
}

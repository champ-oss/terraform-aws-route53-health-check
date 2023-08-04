resource "aws_sns_topic" "this" {
  name = "${var.git}-r53-health-check-${random_string.identifier.result}"
  tags = merge(local.tags, var.tags)
}

resource "aws_sns_topic_subscription" "this" {
  count     = var.alarms_email != null ? 1 : 0
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.alarms_email
}

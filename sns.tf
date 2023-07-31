resource "aws_sns_topic" "this" {
  provider = aws.virginia
  name     = "${var.git}-r53-health-check-${random_string.identifier.result}"
  tags     = local.tags
}

resource "aws_sns_topic_subscription" "this" {
  provider  = aws.virginia
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.alarms_email
}
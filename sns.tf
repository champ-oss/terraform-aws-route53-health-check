resource "aws_sns_topic" "this" {
  name = "${var.git}-r53-health-check-${random_string.identifier.result}"
  tags = merge(local.tags, var.tags)
}

resource "aws_sns_topic_subscription" "this" {
  count                      = var.webhook_url != null ? 1 : 0
  topic_arn                  = aws_sns_topic.this.arn
  protocol                   = "https"
  endpoint                   = var.webhook_url
  endpoint_auto_confirms     = true
}

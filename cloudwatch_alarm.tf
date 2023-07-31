resource "aws_cloudwatch_metric_alarm" "this" {
  provider            = aws.virginia
  alarm_name          = "${var.git}-health-check-${random_string.identifier.result}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = var.period
  statistic           = "Minimum"
  threshold           = "1"
  alarm_description   = "health check for ${aws_route53_health_check.this.fqdn}"
  alarm_actions       = [aws_sns_topic.this.arn]
  ok_actions          = [aws_sns_topic.this.arn]
  tags                = merge(local.tags, var.tags)
  dimensions = {
    HealthCheckId = aws_route53_health_check.this.id
  }
}
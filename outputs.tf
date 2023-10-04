output "cloudwatch_metric_arn" {
  description = "cloudwatch metric arn"
  value       = aws_cloudwatch_metric_alarm.this.arn
}

output "cloudwatch_metric_alarm_name" {
  description = "cloudwatch metric alarm name"
  value       = aws_cloudwatch_metric_alarm.this.alarm_name
}

output "r53_health_check_id" {
  description = "route53 health check id"
  value       = aws_route53_health_check.this.id
}

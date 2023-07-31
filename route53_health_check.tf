resource "aws_route53_health_check" "this" {
  reference_name    = "${var.git}-health-check-${random_string.identifier.result}"
  fqdn              = var.fqdn
  port              = var.port
  type              = var.type
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval
  regions           = var.health_check_regions
  tags              = merge(local.tags, var.tags)
  measure_latency   = var.measure_latency
}

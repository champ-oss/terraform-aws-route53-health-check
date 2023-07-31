resource "aws_route53_health_check" "this" {
  reference_name    = substr("${var.git}-${random_string.identifier.result}", 0, 27) # 27 max length
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

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-route53-health-check"
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "resource_path" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#resource_path"
  type        = string
  default     = "/"
}

variable "failure_threshold" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#failure_threshold"
  type        = number
  default     = 3
}

variable "request_interval" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#request_interval"
  type        = number
  default     = 30
}

variable "alarm_evaluation_periods" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#evaluation_periods"
  type        = number
  default     = 1
}

variable "period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#period"
  type        = number
  default     = 60
}

variable "alarms_email" {
  description = "https://registry.terraform.io/providers/-/aws/latest/docs/resources/sns_topic_subscription#endpoint"
  type        = string
  default     = null
}

variable "type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#type"
  type        = string
  default     = "HTTPS"
}

variable "fqdn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#fqdn"
  type        = string
  default     = "example.com"
}

variable "health_check_regions" {
  description = "AWS Regions for health check"
  type        = list(string)
  default     = ["us-east-1", "us-west-1", "us-west-2"]
}

variable "measure_latency" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#measure_latency"
  type        = bool
  default     = true
}

variable "port" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check#port"
  type        = number
  default     = 443
}


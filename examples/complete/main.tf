terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.71.0"
    }
  }
}

locals {
  tags = {
    git     = "terraform-aws-route53-health-check"
    cost    = "shared"
    creator = "terraform"
  }
}

locals {
  git = "tf-r53-health-check"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.117-6aa9478"
  git               = local.git
  domain_name       = "${local.git}.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "cloudfront" {
  source     = "github.com/champ-oss/terraform-aws-cloudfront.git?ref=v1.0.7-2992b51"
  git        = local.git
  name       = "cloudfront"
  protect    = false
  tags       = local.tags
  enable_waf = false
  zone_id    = data.aws_route53_zone.this.zone_id
  domain     = data.aws_route53_zone.this.name
  dns_name   = local.git
  addresses  = [] # addresses allowed in waf
}

resource "aws_s3_object" "index" {
  bucket       = module.cloudfront.s3_bucket
  key          = "site/main"
  source       = "main"
  content_type = "text/html"
  etag         = filemd5("main")
  depends_on   = [module.cloudfront]
}

resource "aws_s3_object" "static" {
  bucket       = module.cloudfront.s3_bucket
  key          = "site/static/index.css"
  source       = "index.css"
  content_type = "text/css"
  etag         = filemd5("index.css")
  depends_on   = [module.cloudfront]
}

module "this" {
  source        = "../../"
  fqdn          = "${local.git}.${data.aws_route53_zone.this.name}"
  resource_path = "/site/main"
}

output "route53_health_check_id" {
  description = "log group name for alert module function"
  value       = module.this.r53_health_check_id
}

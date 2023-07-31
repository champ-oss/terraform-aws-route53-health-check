terraform {
  backend "s3" {}
}

locals {
  tags = {
    git     = "terraform-aws-route53-health-check"
    cost    = "shared"
    creator = "terraform"
  }
}

provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-r53-health-check"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.111-28fcc7c"
  git               = local.git
  domain_name       = "${local.git}.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "cloudfront" {
  source     = "github.com/champ-oss/terraform-aws-cloudfront.git?ref=v1.0.0-b62c9fa"
  git        = substr(local.git, 0, 60)
  name       = "cloudfront"
  protect    = false
  tags       = local.tags
  enable_waf = false
  zone_id    = data.aws_route53_zone.this.zone_id
  domain     = data.aws_route53_zone.this.name
  dns_name   = local.git
  addresses  = [] # addresses allowed in waf
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "aws s3 cp src/index.html s3://${module.this.s3_bucket}"
  }
}

module "this" {
  source     = "../../"
  fqdn       = "${local.git}.${data.aws_route53_zone.this.name}"
}

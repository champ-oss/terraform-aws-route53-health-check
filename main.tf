provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

locals {
  tags = {
    git     = "terraform-aws-route53-health-check"
    cost    = "shared"
    creator = "terraform"
  }
}

resource "random_string" "identifier" {
  length  = 5
  special = false
  upper   = false
  lower   = true
  number  = true
}

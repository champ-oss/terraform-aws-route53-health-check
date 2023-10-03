#!/bin/bash
  for i in {1..10}
 do
    curl --silent --fail terraform-aws-route53-health-check.oss.champtest.net/site/main
    sleep 15
 done

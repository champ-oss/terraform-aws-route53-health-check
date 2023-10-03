set -e

sleep 30

aws route53 get-health-check-status --health-check-id $ROUTE53_HEALTH_CHECK_ID | jq -e '.HealthCheckObservations[] | select(.StatusReport.Status)' | grep Success
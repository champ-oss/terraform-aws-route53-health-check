set -e -o pipefail



sleep 600

cmd=`aws route53 get-health-check-status --health-check-id $ROUTE53_HEALTH_CHECK_ID | jq -e '.HealthCheckObservations[] | select(.StatusReport.Status)' | grep Success`

for i in 1 2 3 4 5 6 7 8 9 10; do command && break || sleep 60; done
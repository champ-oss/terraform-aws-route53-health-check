set -e

for i in {1..12}; do
  aws route53 get-health-check-status --health-check-id $ROUTE53_HEALTH_CHECK_ID | jq -e '.HealthCheckObservations[] | select(.StatusReport.Status)' | grep Success
  result=$?
  if [[ $result -eq 0 ]]
  then
    break
  else
    sleep 10
  fi
done

if [[ $result -ne 0 ]]
then
  exit 1
fi


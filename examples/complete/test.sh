
command=$(aws route53 get-health-check-status --health-check-id $ROUTE53_HEALTH_CHECK_ID | jq -e '.HealthCheckObservations[] | select(.StatusReport.Status)')

for i in {1..20}
do
   if echo "$command" | grep -q "Success"
   then
     echo "substring found"
      break
   fi
   echo "not found"
   sleep 120
done || exit 1

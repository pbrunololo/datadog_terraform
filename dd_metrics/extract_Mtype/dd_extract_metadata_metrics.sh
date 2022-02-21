#!/bin/bash

path=/PATH/ #PATH
filename=prova.txt #LIST METRICS FILE
api_key=????? #DD_API_KEY
app_key=????? #DD_APP_KEY
dd_site="api.datadoghq.eu"

for metrics_name in  $(cat $path/$filename);do
	cd $path
	echo $metrics_name

# Curl command
	type=$(curl -X GET "https://$dd_site/api/v1/metrics/${metrics_name}" -H "Content-Type: application/json" -H "DD-API-KEY: ${api_key}" -H "DD-APPLICATION-KEY: ${app_key}" | jq -r ".type")
	echo $type
	echo "$metrics_name,$type" >> $path/final_metrics.txt
done

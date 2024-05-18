#!/bin/bash

# Allow SNMP
gcloud compute --project=mitigas-final firewall-rules create allow-snmp --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=udp:161,udp:162 --source-ranges=0.0.0.0/0 --target-tags=allow-snmp

# Allow MySQL
gcloud compute --project=mitigas-final firewall-rules create allow-mysql --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:3306 --source-ranges=0.0.0.0/0 --target-tags=allow-mysql


#!/bin/bash

# Allow SNMP: all
gcloud compute --project=mitigas-final firewall-rules create allow-snmp --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=udp:161,udp:162 --source-ranges=0.0.0.0/0 --target-tags=allow-snmp

# Allow MySQL: db
gcloud compute --project=mitigas-final firewall-rules create allow-mysql --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:3306 --source-ranges=0.0.0.0/0 --target-tags=allow-mysql

# Allow HTTP: company-profile-1, company-profile-2, ecommerce-1, ecommerce-2
gcloud compute --project=mitigas-final firewall-rules create allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=allow-http

# Allow HTTPS
gcloud compute --project=mitigas-final firewall-rules create allow-https --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=allow-https

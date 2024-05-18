#!/bin/bash

# Allow SNMP: all
gcloud compute --project=mitigas-final firewall-rules create allow-snmp --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=udp:161,udp:162 --source-ranges=0.0.0.0/0 --target-tags=allow-snmp

# Allow MySQL: db
gcloud compute --project=mitigas-final firewall-rules create allow-mysql --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:3306 --source-ranges=0.0.0.0/0 --target-tags=allow-mysql

# Allow HTTP: company-profile-1, company-profile-2, ecommerce-1, ecommerce-2, lb-company-profile, lb-ecommerce, fileserver
gcloud compute --project=mitigas-final firewall-rules create allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=allow-http

# Allow HTTPS: all
gcloud compute --project=mitigas-final firewall-rules create allow-https --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=allow-https

# Allow LDAP: openldap
gcloud compute --project=mitigas-final firewall-rules create allow-ldap --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:389 --source-ranges=0.0.0.0/0 --target-tags=allow-ldap

# Allow LDAPS: openldap
gcloud compute --project=mitigas-final firewall-rules create allow-ldaps --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:636 --source-ranges=0.0.0.0/0 --target-tags=allow-ldaps

# Allow phpLDAPadmin: phpldapadmin
gcloud compute --project=mitigas-final firewall-rules create allow-phpldapadmin --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8082 --source-ranges=0.0.0.0/0 --target-tags=allow-phpldapadmin

# Allow Keycloak: keycloak
gcloud compute --project=mitigas-final firewall-rules create allow-keycloak --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8081 --source-ranges=0.0.0.0/0 --target-tags=allow-keycloak

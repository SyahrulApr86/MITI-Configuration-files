#!/bin/bash


# Allow MySQL: db
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-mysql --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:3306 --source-ranges=0.0.0.0/0 --target-tags=allow-mysql

# Allow HTTP: company-profile-1, company-profile-2, ecommerce-1, ecommerce-2, lb-company-profile, lb-ecommerce, fileserver
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=allow-http

# Allow HTTPS: all
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-https --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=allow-https

# Allow LDAP: openldap
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-ldap --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:389 --source-ranges=0.0.0.0/0 --target-tags=allow-ldap

# Allow LDAPS: openldap
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-ldaps --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:636 --source-ranges=0.0.0.0/0 --target-tags=allow-ldaps

# Allow phpLDAPadmin: phpldapadmin
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-phpldapadmin --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8082 --source-ranges=0.0.0.0/0 --target-tags=allow-phpldapadmin

# Allow Keycloak: keycloak
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-keycloak --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8081 --source-ranges=0.0.0.0/0 --target-tags=allow-keycloak

# Allow node_exporter: all nodes running node_exporter
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-node-exporter --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9100 --source-ranges=0.0.0.0/0 --target-tags=allow-node-exporter

# Allow cAdvisor: all nodes running cAdvisor
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-cadvisor --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8080 --source-ranges=0.0.0.0/0 --target-tags=allow-cadvisor

# Allow Prometheus: prometheus
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-prometheus --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9090 --source-ranges=0.0.0.0/0 --target-tags=allow-prometheus

# Allow Alertmanager: alertmanager
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-alertmanager --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9093 --source-ranges=0.0.0.0/0 --target-tags=allow-alertmanager

# Allow Grafana: grafana
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-grafana --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:3000 --source-ranges=0.0.0.0/0 --target-tags=allow-grafana

# Allow Pushgateway: pushgateway
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-pushgateway --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9091 --source-ranges=0.0.0.0/0 --target-tags=allow-pushgateway

# Allow Portainer: portainer
gcloud compute --project=${PROJECT_ID} firewall-rules create allow-portainer --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:8000,tcp:9443 --source-ranges=0.0.0.0/0 --target-tags=allow-portainer

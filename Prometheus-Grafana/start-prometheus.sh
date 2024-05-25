#!/bin/sh

# Export variables
export NODE_EXPORTER_COMPANY_PROFILE_1 NODE_EXPORTER_COMPANY_PROFILE_2 NODE_EXPORTER_DB
export NODE_EXPORTER_ECOMMERCE_1 NODE_EXPORTER_ECOMMERCE_2 NODE_EXPORTER_FILESERVER
export NODE_EXPORTER_LB_COMPANY_PROFILE NODE_EXPORTER_LB_ECOMMERCE NODE_EXPORTER_LDAP
export NODE_EXPORTER_MONITORING_OBSERVIUM NODE_EXPORTER_MONITORING_PORTAINER
export CADVISOR_COMPANY_PROFILE_1 CADVISOR_COMPANY_PROFILE_2 CADVISOR_DB
export CADVISOR_ECOMMERCE_1 CADVISOR_ECOMMERCE_2 CADVISOR_FILESERVER
export CADVISOR_LB_COMPANY_PROFILE CADVISOR_LB_ECOMMERCE CADVISOR_LDAP
export CADVISOR_MONITORING_OBSERVIUM CADVISOR_MONITORING_PORTAINER

# Substitute variables and run Prometheus
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml
cat /etc/prometheus/prometheus.yml
exec /bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/etc/prometheus/console_libraries --web.console.templates=/etc/prometheus/consoles --storage.tsdb.retention.time=200h --web.enable-lifecycle

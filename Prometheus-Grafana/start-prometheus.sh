#!/bin/sh

# Export variables
export NODE_EXPORTER_1 NODE_EXPORTER_2 CADVISOR_1 CADVISOR_2 DATABASE_1 DATABASE_2
export ECOMMERCE_1 ECOMMERCE_2 ECOMMERCE_3 ECOMMERCE_4 FILESERVER_1 FILESERVER_2
export LOAD_BALANCER_1 LOAD_BALANCER_2 LOAD_BALANCER_3 LOAD_BALANCER_4
export MONITORING_OBSERVIUM_1 MONITORING_OBSERVIUM_2 MONITORING_PORTAINER_1 MONITORING_PORTAINER_2

# Substitute variables and run Prometheus
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml
cat /etc/prometheus/prometheus.yml
exec /bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/etc/prometheus/console_libraries --web.console.templates=/etc/prometheus/consoles --storage.tsdb.retention.time=200h --web.enable-lifecycle

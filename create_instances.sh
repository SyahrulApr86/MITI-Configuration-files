#!/bin/bash

source gcloud.env

# Ganti dengan zona yang Anda gunakan dalam proyek baru
ZONE="us-central1-c"
# Ganti dengan tipe mesin yang Anda inginkan, mungkin tidak perlu diubah kecuali jika menggunakan tipe mesin yang berbeda
MACHINE_TYPE="e2-small"
# Image OS yang digunakan, mungkin tidak perlu diubah kecuali jika menggunakan image yang berbeda
IMAGE="projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240519"
# Konfigurasi jaringan, mungkin tidak perlu diubah
NETWORK_INTERFACE="network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default"
# Tipe disk, mungkin tidak perlu diubah kecuali jika menggunakan tipe disk yang berbeda
DISK_TYPE="pd-balanced"


# Cakupan API, mungkin tidak perlu diubah
SCOPES="https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append"

create_instance() {
    gcloud compute instances create $1 \
        --project=$PROJECT \
        --zone=$ZONE \
        --machine-type=$MACHINE_TYPE \
        --network-interface=$NETWORK_INTERFACE \
        --maintenance-policy=MIGRATE \
        --provisioning-model=STANDARD \
        --service-account=$SERVICE_ACCOUNT \
        --scopes=$SCOPES \
        --tags=$2 \
        --create-disk=auto-delete=yes,boot=yes,device-name=$1,image=$IMAGE,mode=rw,size=10,type=projects/$PROJECT/zones/$ZONE/diskTypes/$DISK_TYPE \
        --no-shielded-secure-boot \
        --shielded-vtpm \
        --shielded-integrity-monitoring \
        --labels=goog-ec-src=vm_add-gcloud \
        --reservation-affinity=any
}

create_instance "company-profile-1" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "company-profile-2" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "db" "allow-mysql,allow-cadvisor,allow-node-exporter"
create_instance "ecommerce-1" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "ecommerce-2" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "fileserver" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "lb-company-profile" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "lb-ecommerce" "allow-http,allow-https,allow-cadvisor,allow-node-exporter"
create_instance "ldap" "allow-ldap,allow-ldaps,allow-phpldapadmin,allow-cadvisor,allow-node-exporter,allow-keycloak"
create_instance "monitoring-observium" "allow-node-exporter,allow-cadvisor,allow-http,allow-https"
create_instance "monitoring-prome-grafana" "allow-prometheus,allow-alertmanager,allow-grafana,allow-pushgateway,allow-cadvisor,allow-node-exporter"
create_instance "monitoring-portainer" "allow-portainer,allow-cadvisor,allow-node-exporter"

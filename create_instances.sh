#!/bin/bash

# Ganti dengan ID proyek baru
PROJECT="new-project-id"
# Ganti dengan zona yang Anda gunakan dalam proyek baru
ZONE="us-central1-c"
# Ganti dengan tipe mesin yang Anda inginkan, mungkin tidak perlu diubah kecuali jika menggunakan tipe mesin yang berbeda
MACHINE_TYPE="e2-small"
# Image OS yang digunakan, mungkin tidak perlu diubah kecuali jika menggunakan image yang berbeda
IMAGE="projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240515"
# Konfigurasi jaringan, mungkin tidak perlu diubah
NETWORK_INTERFACE="network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default"
# Tipe disk, mungkin tidak perlu diubah kecuali jika menggunakan tipe disk yang berbeda
DISK_TYPE="pd-balanced"

TAGS="http-server,https-server,lb-health-check"
# Ganti dengan akun layanan baru dari proyek baru
SERVICE_ACCOUNT="new-service-account@developer.gserviceaccount.com"
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
        --tags=$TAGS \
        --create-disk=auto-delete=yes,boot=yes,device-name=$1,image=$IMAGE,mode=rw,size=10,type=projects/$PROJECT/zones/$ZONE/diskTypes/$DISK_TYPE \
        --no-shielded-secure-boot \
        --shielded-vtpm \
        --shielded-integrity-monitoring \
        --labels=goog-ec-src=vm_add-gcloud \
        --reservation-affinity=any
}

create_instance "company-profile-1"
create_instance "company-profile-2"
create_instance "db"
create_instance "ecommerce-1"
create_instance "ecommerce-2"
create_instance "fileserver"
create_instance "lb-company-profile"
create_instance "lb-ecommerce"
create_instance "ldap"
create_instance "monitoring-observium"
create_instance "monitoring-prome-grafana"
create_instance "monitoring-portainer"

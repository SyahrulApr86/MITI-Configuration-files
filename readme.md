
# MITIGAS Configuration File

Repositori ini berisi file Docker Compose dan konfigurasi untuk berbagai layanan yang digunakan dalam organisasi e-commerce kami. Layanan tersebut mencakup situs profil perusahaan, platform e-commerce, file server, server database, alat pemantauan, dan server login SSO. Setiap layanan dikonfigurasi untuk berjalan pada instance terpisah di Google Cloud Platform (GCP).

## Daftar Konten

- [Ringkasan Proyek](#ringkasan-proyek)
- [Prasyarat](#prasyarat)
- [Mengubah Kuota Alamat IP Statis](#mengubah-kuota-alamat-ip-statis)
- [Membuat Instance di GCP](#membuat-instance-di-gcp)
- [Struktur Direktori](#struktur-direktori)
- [Informasi Tambahan](#informasi-tambahan)


## Ringkasan Proyek

Organisasi menggunakan instance berikut:

- **Company Profile**: Instance untuk menampilkan halaman profil perusahaan dengan load balancing.
- **E-commerce**: Instance untuk menampilkan dan mengelola platform e-commerce dengan load balancing.
- **File Server**: Instance untuk berbagi dan menyimpan file antar anggota tim.
- **Database Server**: Instance untuk menyimpan dan mengelola database.
- **Monitoring**: Instance untuk memantau infrastruktur, termasuk fileserver, profil web, server database, dan e-commerce.
- **SSO Login Server**: Instance untuk mengelola single sign-on untuk berbagai layanan.

## Prasyarat

Sebelum memulai, pastikan Anda memiliki:

- Akses ke Google Cloud Platform dengan izin yang diperlukan
- Proyek yang telah disiapkan di GCP

## Mengubah Kuota "In-use IP Addresses" di GCP 

Sebelum membuat instance di GCP, pastikan Anda memiliki kuota "In-use IP addresses" yang cukup untuk proyek Anda. Jika kuota saat ini tidak mencukupi, Anda perlu meminta peningkatan kuota sebelum membuat instance baru. Untuk mengubah kuota alamat IP yang sedang digunakan menjadi 30 (sesuaikan dengan kebutuhan), ikuti langkah-langkah berikut menggunakan Google Cloud Console:

1. **Buka Halaman Kuota di Google Cloud Console:**
    - Kunjungi halaman [Quotas](https://console.cloud.google.com/iam-admin/quotas).

2. **Filter Kuota:**
    - Klik tombol filter (`filter_list`) untuk memfilter kuota berdasarkan properti spesifik.
    - Gunakan kotak pencarian Filter untuk mencari kuota "In-use IP addresses"

3. **Pilih Kuota "In-use IP addresses":**
    - Temukan kuota "In-use IP addresses" di kolom Quota.
    - Centang kotak di sebelah kuota tersebut.
    - Pastikan kuota yang dipilih sesuai dengan proyek Anda dan juga lokasi yang benar (sebagai contoh, us-central1).
   
![img.png](docs/screenshots/quota-before.png)

4. **Edit Kuota:**
    - Klik `create EDIT QUOTAS`.
    - Pada formulir perubahan kuota, masukkan nilai kuota baru yang Anda inginkan untuk proyek Anda di bidang New limit (contoh: 30).

5. **Kirim Permintaan:**
    - Lengkapi bidang tambahan pada formulir jika diperlukan.
    - Klik `DONE`.
    - Klik `SUBMIT REQUEST`.

Setelah langkah-langkah ini selesai, permintaan Anda untuk meningkatkan kuota akan diproses oleh Google Cloud.
    
- Jika permintaan Anda disetujui, Anda akan melihat kuota "In-use IP addresses" yang ditingkatkan di halaman Quotas.

    ![img.png](docs/screenshots/quota-after.png)

## Membuat Instance di GCP

Skrip berikut mengotomatisasi pembuatan instance yang diperlukan di GCP menggunakan perintah CLI. Simpan skrip ini sebagai `create_instances.sh` dan jalankan untuk membuat semua instance.

```bash
#!/bin/bash

PROJECT="mitigas-final"
ZONE="us-central1-c"
MACHINE_TYPE="e2-small"
IMAGE="projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240515"
NETWORK_INTERFACE="network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default"
DISK_TYPE="pd-balanced"
TAGS="http-server,https-server,lb-health-check"
SERVICE_ACCOUNT="534129012887-compute@developer.gserviceaccount.com"
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
```

### Cara Menggunakan

1. **Salin Skrip:**
    
    - Copy skrip `create_instances.sh` ke cloud shell.
   
      ![img.png](/docs/screenshots/cloud-active-shell.png)
   
    - Gunakan perintah untuk membuat direktori baru dan buka file `create_instances.sh`:
        ```bash
        mkdir "create_instances"
        cd create_instances
        nano create_instances.sh
        ```
   - Masukkan skrip di atas ke dalam file `create_instances.sh`.
    - Berikan izin eksekusi ke skrip:
      ```bash
      chmod +x create_instances.sh
      ```


2. **Buat Instance:**
    - Pastikan Anda telah menyiapkan proyek GCP Anda dan memiliki izin yang diperlukan.
    - Jalankan skrip `create_instances.sh` untuk membuat semua instance yang diperlukan:
      ```bash
      ./create_instances.sh
      ```
    - Tunggu hingga semua instance selesai dibuat.
   ![img.png](/docs/screenshots/instances created.png)

3. **Konfigurasi Instance:**
    - Masuk ke dalam Compute Engine di menu sebalah kiri. Anda akan melihat semua instance yang baru dibuat.
    ![img.png](docs/screenshots/gce.png)
    - Konfigurasikan setiap instance sesuai kebutuhan Anda.
   ![img.png](docs/screenshots/gce-running.png)
   

## Struktur Direktori

- `Company-Profile`: File Docker Compose dan konfigurasi untuk instance profil perusahaan.
- `Docker-Compose-Prometheus-and-Grafana-master`: Pengaturan pemantauan dengan Prometheus dan Grafana.
- `ECommerce-Joomla`: Platform e-commerce menggunakan Joomla.
- `Ecommerce-Wordpress`: Platform e-commerce menggunakan WordPress.
- `ldap`: File konfigurasi LDAP.
- `MySQL`: File konfigurasi database MySQL.
- `Nextcloud`: Pengaturan file server menggunakan Nextcloud.
- `Nginx-lb-Company-Profile-Wordpress`: Nginx load balancer untuk profil perusahaan menggunakan WordPress.
- `Nginx-lb-ECommerce-Wordpress`: Nginx load balancer untuk platform e-commerce menggunakan WordPress.
- `Observium`: Pengaturan pemantauan menggunakan Observium.
- `Portainer`: Antarmuka manajemen Docker menggunakan Portainer.
- `Wordpress-All-in-One`: Pengaturan all-in-one untuk WordPress.

## Informasi Tambahan

Untuk konfigurasi dan langkah-langkah setup yang lebih detail, lihat file README di setiap direktori. Pastikan semua layanan dikonfigurasi dengan benar dan berjalan sesuai harapan.

Jika Anda menghadapi masalah atau memiliki pertanyaan, silakan merujuk pada dokumentasi atau menghubungi pemelihara proyek.

---

Jangan ragu untuk menyesuaikan README ini sesuai dengan kebutuhan spesifik Anda dan tambahkan informasi tambahan yang mungkin berguna bagi pengguna.

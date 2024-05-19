
# Observium Installation Guide

![Observium Logo](image/observium-logo.png)
Repositori ini berisi panduan untuk menginstal Observium secara manual di server Anda. Observium adalah perangkat lunak pemantauan jaringan yang mendukung berbagai perangkat.

## Daftar Konten

- [Struktur Direktori](#struktur-direktori)
- [Prasyarat](#prasyarat)
- [Instalasi Observium](#instalasi-observium)
    - [Mengunduh dan Menjalankan Skrip Instalasi](#mengunduh-dan-menjalankan-skrip-instalasi)
    - [Menjawab Prompt Selama Instalasi](#menjawab-prompt-selama-instalasi)
- [Mengakses Observium](#mengakses-observium)
- [Troubleshooting](#troubleshooting)
- [Port yang Digunakan](#port-yang-digunakan)
    - [Langkah-langkah Membuka Port](#langkah-langkah-membuka-port)
        - [Di Docker Host](#di-docker-host)
        - [Di Google Cloud Platform (GCP)](#di-google-cloud-platform-gcp)
- [Informasi Tambahan](#informasi-tambahan)

## Struktur Direktori

- `readme.md`: File dokumentasi ini.
- `image`: Direktori yang berisi gambar untuk dokumentasi.
    - `observium-logo.png`: Logo Observium.

## Prasyarat

Pastikan Anda memiliki server dengan sistem operasi berbasis Linux dan akses root. Anda juga memerlukan akses internet untuk mengunduh skrip instalasi dan dependensi.

## Instalasi Observium

### Mengunduh dan Menjalankan Skrip Instalasi

1. **Mengunduh Skrip Instalasi:**
   ```bash
   wget http://www.observium.org/observium_installscript.sh
   sudo chmod +x observium_installscript.sh
   ```

2. **Menjalankan Skrip Instalasi:**
   Jalankan skrip instalasi dan ikuti petunjuk yang muncul:
   ```bash
   sudo ./observium_installscript.sh
   ```

### Menjawab Prompt Selama Instalasi

Selama instalasi, Anda akan diminta untuk menjawab beberapa prompt. Berikut adalah contoh interaksi yang diperlukan:

1. **Pemilihan Versi Observium:**
   ```
   Please choose which version of Observium you would like to install
   1. Observium Community Edition
   2. Observium Pro/Ent Edition stable (requires account at https://www.observium.org/subs/)
   3. Observium Pro/Ent Edition rolling (requires account at https://www.observium.org/subs/)
   4. Install the UNIX-Agent
   5. Install the SNMPD (snmpd-config will be overwritten)
   (1-5): 1
   ```

2. **Memilih Password MySQL:**
   ```
   Choose a MySQL root password
   input: [your-mysql-password]
   ```

3. **Konfirmasi Instalasi Paket:**
   ```
   Do you want to continue? [Y/n] 
   input: y
   ```

4. **Membuat User Admin Observium:**
   ```
   Create first time Observium admin user..
   Username: [your-admin-username]
   Password: [your-admin-password]
   ```

5. **Mengkonfigurasi dan Memasang SNMP Daemon:**
   ```
   Would you like to install/configure SNMP daemon and monitor this host with Observium? (your snmpd-config will be overwritten!) (Y/n):
   input: y
   ```

6. **Memasang UNIX-agent:**
   ```
   Would you like to install the UNIX-agent on this host? (y/N): 
   input: y
   ```

Instalasi selesai dan Observium siap digunakan.

## Mengakses Observium

Setelah instalasi selesai, Anda dapat mengakses Observium melalui browser menggunakan IP atau hostname server Anda:

- URL: `http://<server-ip>/`

Login menggunakan kredensial yang Anda buat selama instalasi.

## Menambahkan Device ke Observium

Untuk memantau perangkat, Anda perlu menambahkan perangkat ke Observium. Berikut adalah langkah-langkah umum untuk menambahkan perangkat:

1. Sebelum menambahkan perangkat, pastikan SNMP telah diaktifkan pada perangkat yang akan dimonitor, jika belum, aktifkan SNMP pada perangkat dengan cara sebagai berikut:
    ```bash
    sudo apt install snmpd snmp libsnmp-dev -y
    ```
2. Edit file `/etc/snmp/snmpd.conf` dengan mengganti baris `agentAddress 127.0.0.1,[::1]` menjadi `agentAddress udp:161,udp6:[::1]:161` hal ini memiliki tujuan untuk mengubah cara agen SNMP (Simple Network Management Protocol) mendengarkan permintaan jaringan. Jangan lupa untuk melakukan backup file konfigurasi sebelum melakukan perubahan.
    ```bash
    sudo cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak
    ```
   Berikut penjelasan detailnya:
   - **Konfigurasi Awal: `agentAddress 127.0.0.1,[::1]`**:
       - `127.0.0.1`: Agen SNMP hanya mendengarkan permintaan SNMP di alamat loopback IPv4 (localhost).
       - `[::1]`: Agen SNMP hanya mendengarkan permintaan SNMP di alamat loopback IPv6 (localhost).

      Konfigurasi ini membatasi akses SNMP hanya ke localhost, yang berarti hanya aplikasi yang berjalan di mesin yang sama dengan agen SNMP yang dapat mengirim permintaan SNMP.

   - **Konfigurasi Baru: `agentAddress udp:161,udp6:[::1]:161`**:
       - `udp:161`: Agen SNMP akan mendengarkan permintaan SNMP di semua alamat jaringan yang tersedia pada port UDP 161 untuk IPv4. Ini memungkinkan akses SNMP dari mesin lain di jaringan.
       - `udp6:[::1]:161`: Agen SNMP akan mendengarkan permintaan SNMP di alamat loopback IPv6 pada port UDP 161.

      Konfigurasi ini memungkinkan agen SNMP untuk menerima permintaan SNMP dari jaringan eksternal pada port 161, bukan hanya dari localhost. Dengan kata lain, SNMP sekarang dapat diakses dari mesin lain di jaringan.
   Lakukan restart SNMP daemon:
   ```bash
    sudo systemctl restart snmpd
    ```
   Lakukan hal di atas pada semua perangkat yang akan dimonitor (Anda bisa automatisasi dengan menggunakan Ansible)

3. Masuk ke Observium melalui browser.
4. Klik **Add Device** di bagian atas halaman.
5. Masukkan informasi perangkat yang akan dimonitor (masukkan sesuai kebutuhan Anda):
    - **Hostname**: Nama host perangkat.
    - **SNMP Version**: Versi SNMP yang digunakan oleh perangkat.
    - **SNMP Community**: Community string yang digunakan untuk mengakses perangkat.
    - **SNMP Port**: Port SNMP yang digunakan oleh perangkat.
    - **SNMP Timeout**: Waktu tunggu untuk permintaan SNMP.
    - **SNMP Retries**: Jumlah percobaan ulang untuk permintaan SNMP.
6. Klik **Add Device** untuk menambahkan perangkat.

Hal di atas juga dapat anda automatisasi dengan menggunakan Ansible.




## Troubleshooting

Jika Anda mengalami masalah selama instalasi atau penggunaan Observium, Anda dapat memeriksa log untuk informasi lebih lanjut:

```bash
sudo tail -f /opt/observium/logs/observium.log
```

## Port yang Digunakan

Berdasarkan konfigurasi default, Observium menggunakan port 80 untuk HTTP. Jika Anda menggunakan HTTPS, pastikan port 443 juga terbuka.

### Langkah-langkah Membuka Port

Anda bisa mengikuti langkah-langkah berikut untuk membuka port yang diperlukan, atau Anda dapat melihat [Cara Membuat Firewall Rules](../readme.md#membuat-firewall-rules-di-gcp) jika menggunakan Google Cloud Platform.

#### Di Docker Host

Pastikan bahwa port yang diperlukan dibuka pada firewall di host Docker Anda. Jika Anda menggunakan ufw pada Ubuntu, Anda dapat membuka port dengan perintah berikut:

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw reload
```

#### Di Google Cloud Platform (GCP)

Jika Anda menjalankan instance di GCP, Anda perlu memastikan bahwa port yang diperlukan dibuka pada firewall rules GCP:

1. **Buka Google Cloud Console**.
2. **Navigasi ke VPC Network** > **Firewall**.
3. **Buat Firewall Rule Baru**:
    - Klik tombol **Create Firewall Rule**.
    - Masukkan detail berikut:
        - **Name**: `allow-http-https`
        - **Targets**: `All instances in the network`
        - **Source IP ranges**: `0.0.0.0/0` (untuk akses publik) atau subnet spesifik.
        - **Protocols and ports**: Centang **Specified protocols and ports** dan masukkan `tcp:80`, `tcp:443`.
4. **Klik Create** untuk membuat firewall rule.

## Informasi Tambahan

Untuk informasi lebih lanjut tentang menggunakan dan mengkonfigurasi Observium, silakan merujuk ke dokumentasi resmi:

- [Dokumentasi Observium](https://www.observium.org/documentation/)
- [Dokumentasi Docker](https://docs.docker.com/)
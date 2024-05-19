# Prometheus - Grafana Configuration
![Prometheus-Grafana](screens/prome-grafana-logo.png)

Solusi pemantauan untuk host dan kontainer Docker dengan [Prometheus](https://prometheus.io/), [Grafana](http://grafana.org/), [cAdvisor](https://github.com/google/cadvisor),
[NodeExporter](https://github.com/prometheus/node_exporter) dan sistem peringatan dengan [AlertManager](https://github.com/prometheus/alertmanager).

Ini adalah repositori yang di-fork. Jadi, Anda mungkin ingin mengunjungi repositori asli di [stefanprodan/dockprom](https://github.com/stefanprodan/dockprom)

Info tambahan: [Docker - Prometheus and Grafana](https://bogotobogo.com/DevOps/Docker/Docker_Prometheus_Grafana.php)

## Prasyarat:

* Docker Engine >= 1.13
* Docker Compose >= 1.11

## Kontainer:

* Prometheus (database metrik) `http://<host-ip>:9090`
* Prometheus-Pushgateway (penerima push untuk pekerjaan sementara dan batch) `http://<host-ip>:9091`
* AlertManager (manajemen peringatan) `http://<host-ip>:9093`
* Grafana (visualisasi metrik) `http://<host-ip>:3000`
* NodeExporter (pengumpul metrik host) `http://<host-ip>:9100`
* cAdvisor (pengumpul metrik kontainer) `http://<host-ip>:8080`

## Instalasi

1. **Kloning Repositori:**
   ```bash
   git clone https://github.com/SyahrulApr86/MITI-Configuration-files.git
   cd MITI-Configuration-files/Prometheus-Grafana
   ```

2. **Menjalankan NodeExporter dan cAdvisor pada masing-masing host yang ingin dipantau:**
   Anda dapat menjalankan NodeExporter dan cAdvisor pada tiap host dengan menjalankan docker compose yang ada di folder `./exporter`:
    ```yaml
    services:
      nodeexporter:
        image: prom/exporter:v1.8.0
        container_name: nodeexporter
        volumes:
          - /proc:/host/proc:ro
          - /sys:/host/sys:ro
          - /:/rootfs:ro
        command:
          - '--path.procfs=/host/proc'
          - '--path.rootfs=/rootfs'
          - '--path.sysfs=/host/sys'
          - '--collector.filesystem.ignored-mount-points=^/(sys|proc|dev|host|etc)($$|/)'
        restart: unless-stopped
        network_mode: host
        labels:
          org.label-schema.group: "monitoring"
    
      cadvisor:
        image: gcr.io/cadvisor/cadvisor:v0.49.1
        container_name: cadvisor
        volumes:
          - /:/rootfs:ro
          - /var/run:/var/run:rw
          - /sys:/sys:ro
          - /var/lib/docker/:/var/lib/docker:ro
          - /dev/disk/:/dev/disk:ro
        restart: unless-stopped
        network_mode: host
        privileged: true
        devices:
          - /dev/kmsg
        labels:
          org.label-schema.group: "monitoring"
    ```
   Anda harus menjalankannya pada setiap host yang ingin dipantau baik dengan SSH ke masing-masing host atau dengan menggunakan [Ansible](../Ansible/readme.md). Kemudian pastikan Anda membuka port yang diperlukan (9100 dan 8080) pada firewall masing-masing host yang ingin dipantau.

3. **Menjalankan Services pada Host Utama:**
    Selanjutnya anda dapat tinggal menjalankan docker compose pada host utama:
   ```bash
   sudp docker compose up -d
   ```

4. **Pengaturan Grafana**

Buka `http://<host-ip>:3000` dan login dengan pengguna ***admin*** dan kata sandi ***admin***. Anda dapat mengubah kredensial dalam file compose atau dengan menyediakan variabel lingkungan `ADMIN_USER` dan `ADMIN_PASSWORD` melalui file .env saat compose up. File konfigurasi dapat ditambahkan langsung di bagian grafana seperti ini:
```
grafana:
  image: grafana/grafana:5.2.4
  env_file:
    - config
```
dan format file config harus berisi konten berikut:
```
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=changeme
GF_USERS_ALLOW_SIGN_UP=false
```

Grafana sudah dikonfigurasi dengan dasbor dan Prometheus sebagai sumber data default:

* Nama: Prometheus
* Jenis: Prometheus
* Url: http://prometheus:9090

***Docker Host Dashboard***

![Host](screens/Grafana_Docker_Host.png)

Dasbor Docker Host menunjukkan metrik kunci untuk memantau penggunaan sumber daya server Anda:

* Waktu aktif server, persentase CPU idle, jumlah inti CPU, memori yang tersedia, swap, dan penyimpanan
* Grafik rata-rata beban sistem, grafik proses yang berjalan dan diblokir oleh IO, grafik interupsi
* Grafik penggunaan CPU berdasarkan mode (guest, idle, iowait, irq, nice, softirq, steal, system, user)
* Grafik penggunaan memori berdasarkan distribusi (digunakan, gratis, buffer, cache)
* Grafik penggunaan IO (read Bps, write Bps dan waktu IO)
* Grafik penggunaan jaringan berdasarkan perangkat (inbound Bps, outbound Bps)
* Grafik penggunaan dan aktivitas swap

Untuk penyimpanan, khususnya grafik Penyimpanan Gratis, Anda harus menentukan fstype dalam permintaan grafik grafana.
Anda dapat menemukannya di `grafana/dashboards/docker_host.json`, pada baris 480:

      "expr": "sum(node_filesystem_free_bytes{fstype=\"btrfs\"})",

Saya menggunakan BTRFS, jadi saya perlu mengubah `aufs` menjadi `btrfs`.

Anda dapat menemukan nilai yang tepat untuk sistem Anda di Prometheus `http://<host-ip>:9090` dengan menjalankan permintaan ini:

      node_filesystem_free_bytes
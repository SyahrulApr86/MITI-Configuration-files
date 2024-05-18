
# MySQL Database Server Configuration

Repositori ini berisi file konfigurasi untuk menjalankan server database MySQL menggunakan Docker Compose. Server ini akan menjalankan MySQL versi 8.0 dengan beberapa database dan pengguna yang telah dikonfigurasi.

## Struktur Direktori

- `docker-compose.yml`: File Docker Compose utama yang digunakan untuk menjalankan container MySQL.
- `docker-compose.yml.template`: Template file Docker Compose yang dapat disesuaikan dengan kebutuhan.
- `init.sql`: File SQL yang berisi perintah untuk menginisialisasi database saat container pertama kali dijalankan.
- `readme.md`: File dokumentasi ini.

## Cara Menggunakan

### 1. Prasyarat

Pastikan Anda telah menginstal Docker dan Docker Compose di sistem Anda. Jika belum, Anda dapat menginstalnya dengan mengikuti dokumentasi berikut:

- [Instalasi Docker](https://docs.docker.com/get-docker/)
- [Instalasi Docker Compose](https://docs.docker.com/compose/install/)

atau pada [Cara Instalasi Docker](../readme.md#instalasi-docker).

### 2. Menyesuaikan File Template

Jika Anda ingin menyesuaikan konfigurasi, Anda dapat mengedit file `docker-compose.yml.template`. Gantilah placeholder dengan nilai yang sesuai:

```yaml
services:
  db:
    image: mysql:8.0
    restart: always
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: [password] # password untuk user 'root'
      MYSQL_USER: [username] # username untuk user baru, user ini akan mendapat izin sebagai superuser
      MYSQL_PASSWORD: [password] # password untuk user baru
      MYSQL_DATABASE: [database] # nama database yang akan dibuat secara otomatis saat container pertama kali dijalankan
    command: --default-authentication-plugin=caching_sha2_password
    volumes:
      - db_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  db_data:
```

### 3. Menjalankan Container MySQL

1. **Kloning Repositori:**
   ```bash
   git clone https://github.com/SyahrulApr86/MITI-Configuration-files.git
   cd MITI-Configuration-files/MySQL
   ```

2. **Menjalankan Docker Compose:**
   Pastikan Anda berada di direktori yang berisi file `docker-compose.yml`, kemudian jalankan perintah berikut:
   ```bash
   docker-compose up -d
   ```

   Perintah ini akan mendownload image MySQL (jika belum ada), membuat container, dan menjalankan MySQL server dengan konfigurasi yang telah ditentukan.

### 4. Mengakses MySQL Server

Setelah container berjalan, Anda dapat mengakses MySQL server menggunakan klien MySQL atau alat manajemen basis data seperti phpMyAdmin. Gunakan informasi berikut untuk mengakses server:

- Host: `localhost`
- Port: `3306`
- Username: `databaseuser`
- Password: `passworddatabaseuser`
- Database: `initdb`

### 5. Inisialisasi Database

File `init.sql` berisi perintah untuk membuat database tambahan dan memberikan hak akses kepada pengguna `databaseuser`. Berikut adalah isi file `init.sql`:

```sql
CREATE DATABASE IF NOT EXISTS wordpressweb;
CREATE DATABASE IF NOT EXISTS wordpressecomm;
CREATE DATABASE IF NOT EXISTS nextclouddb;
GRANT ALL PRIVILEGES ON wordpressweb.* TO 'databaseuser'@'%';
GRANT ALL PRIVILEGES ON wordpressecomm.* TO 'databaseuser'@'%';
GRANT ALL PRIVILEGES ON nextclouddb.* TO 'databaseuser'@'%';
FLUSH PRIVILEGES;
```

Perintah SQL ini akan dijalankan secara otomatis saat container pertama kali dijalankan.

## Troubleshooting

Jika Anda mengalami masalah saat menjalankan container, Anda dapat memeriksa log dengan perintah berikut:

```bash
docker-compose logs
```

Log ini akan memberikan informasi lebih lanjut tentang apa yang mungkin salah dan bagaimana cara memperbaikinya.

## Informasi Tambahan

Untuk informasi lebih lanjut tentang menggunakan dan mengkonfigurasi MySQL di Docker, silakan merujuk ke dokumentasi resmi MySQL dan Docker:

- [Dokumentasi MySQL](https://dev.mysql.com/doc/)
- [Dokumentasi Docker](https://docs.docker.com/)

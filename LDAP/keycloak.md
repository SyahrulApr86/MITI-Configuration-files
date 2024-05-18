Untuk mengatasi masalah "HTTPS required" di Keycloak, Anda bisa mengikuti langkah-langkah yang Anda temukan untuk menonaktifkan persyaratan HTTPS dalam konfigurasi realm Keycloak. Berikut adalah panduan langkah demi langkah:

### Langkah-Langkah untuk Menonaktifkan HTTPS di Keycloak

1. **Masuk ke Container Keycloak**:
   - Gunakan perintah `docker exec` untuk masuk ke dalam container Keycloak.
     ```bash
     docker exec -it keycloak bash
     ```

2. **Navigasi ke Direktori Keycloak**:
   - Pindah ke direktori bin Keycloak.
     ```bash
     cd /opt/keycloak/bin
     ```

3. **Konfigurasi Kredensial dengan `kcadm.sh`**:
   - Jalankan skrip `kcadm.sh` untuk mengatur kredensial dan mengubah konfigurasi realm.
     ```bash
     ./kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin_password
     ```

4. **Update Realm untuk Nonaktifkan SSL**:
   - Gunakan `kcadm.sh` untuk memperbarui pengaturan realm `master` untuk tidak memerlukan SSL.
     ```bash
     ./kcadm.sh update realms/master -s sslRequired=NONE
     ```

### Langkah-Langkah Lengkap

1. **Masuk ke Container**:
   ```bash
   docker exec -it keycloak bash
   ```

2. **Pindah ke Direktori bin**:
   ```bash
   cd /opt/keycloak/bin
   ```

3. **Konfigurasi Kredensial**:
   ```bash
   ./kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin_password
   ```

4. **Nonaktifkan SSL di Realm**:
   ```bash
   ./kcadm.sh update realms/master -s sslRequired=NONE
   ```

### Ringkasan Perintah yang Digunakan:

- **Masuk ke Container**:
  ```bash
  docker exec -it keycloak bash
  ```

- **Pindah ke Direktori bin**:
  ```bash
  cd /opt/keycloak/bin
  ```

- **Konfigurasi Kredensial**:
  ```bash
  ./kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin_password
  ```

- **Update Realm**:
  ```bash
  ./kcadm.sh update realms/master -s sslRequired=NONE
  ```

### Penjelasan Setiap Langkah:

- **docker exec -it keycloak bash**:
   - Memasuki container Keycloak untuk eksekusi perintah di dalamnya.

- **cd /opt/keycloak/bin**:
   - Navigasi ke direktori yang berisi skrip administrasi Keycloak.

- **./kcadm.sh config credentials**:
   - Mengonfigurasi kredensial admin untuk akses Keycloak CLI.

- **./kcadm.sh update realms/master -s sslRequired=NONE**:
   - Mengubah pengaturan realm `master` agar tidak memerlukan SSL.

Dengan mengikuti langkah-langkah ini, Anda seharusnya dapat mengakses Keycloak tanpa persyaratan HTTPS, memungkinkan Anda untuk melakukan konfigurasi dan pengujian secara lokal dengan lebih mudah.
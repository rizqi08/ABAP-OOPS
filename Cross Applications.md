**Aplikasi Lintas (Cross Applications)**

**Pengenalan**  
- Objek teknis SAP dibagi menjadi 6 area yang berbeda (RICEFW).
  - R - Reports, I - Interfaces, C - Conversion, E - Enhancements, F - Forms, W - Workflow
- Aplikasi lintas SAP adalah bagian dari antarmuka yang membantu mentransfer data antar sistem.
- Dengan bantuan aplikasi lintas, kita dapat mentransfer data dari Non-SAP ke SAP, SAP ke Non-SAP, dan SAP ke SAP.
- Aplikasi lintas yang umum adalah BAPI, RFC, IDOC (ALE & EDI), dll.

**Kebutuhan (Requirement)**  
- Pelanggan akan menyediakan data karyawan dalam file.
- Kami akan memigrasi data karyawan ke sistem SAP menggunakan BAPI dengan antarmuka IDOC.
- Langkah-langkah yang terlibat dalam kebutuhan ini adalah sebagai berikut:
  - **Langkah 1:** Pembuatan BAPI
  - **Langkah 2:** Pembuatan antarmuka IDOC untuk BAPI
  - **Langkah 3:** Migrasi data karyawan menggunakan metode objek bisnis (BAPI dengan antarmuka IDOC) dari LSMW.

**BAPI**  
- B - Business, A - Application, P - Programming, I - Interface
- BAPI adalah antarmuka pemrograman standar yang memungkinkan akses eksternal ke proses bisnis dalam sistem SAP.
- Sistem eksternal (misalnya sistem SAP atau sistem lain yang menggunakan bahasa pemrograman seperti JAVA, Visual Basic, atau C++) dapat memanggil BAPI.
- BAPI dalam sistem SAP diimplementasikan sebagai modul fungsi.
- BAPI = modul fungsi + objek bisnis.

**BAPI (lanjutan)**  
- BAPI didefinisikan dalam repositori objek bisnis (BOR).
- Kode transaksi untuk menampilkan BAPI adalah **BAPI** (BAPI Explorer).

**Prasyarat untuk BAPI**  
- Nama modul fungsi harus dimulai dengan `<namespace>BAPI_<business_object>_<method>`.
- Semua parameter terkait tipe harus dimulai dengan `<namespace>BAPI`.
- Semua parameter harus diteruskan dengan nilai (pass by value).
- Harus ada parameter RETURN dengan tipe 'BAPIRET2'.
- Modul fungsi harus RFC-enabled.
- Modul fungsi harus dilepaskan.

**Pembuatan Objek Bisnis**  
- Kode transaksi untuk pembuat objek bisnis: **SWO1**
- Saat membuat objek bisnis, kita perlu menyediakan hal-hal berikut:
  - **Super Type:** Untuk mewarisi komponen dari jenis objek yang ada.
  - **Object Type:** Digunakan untuk identifikasi internal objek bisnis.
  - **Object Name:** Digunakan untuk identifikasi eksternal objek bisnis. Dengan properti ini, sistem eksternal dapat berinteraksi dengan sistem SAP.
  - **Name:** Nama deskriptif objek bisnis.

**Pembuatan Objek Bisnis (lanjutan)**  
- **Description:** Deskripsi singkat jenis objek bisnis.
- **Program:** Program yang akan berisi kode ABAP dari objek bisnis.
- **Application:** Komponen aplikasi tempat objek bisnis tersebut berada (*menandakan aplikasi lintas*).

**Status Objek Bisnis/Komponen Objek Bisnis**  
- Ada 4 status untuk objek bisnis/komponen objek bisnis:
  1. **Modeled**
  2. **Implemented**
  3. **Released**
  4. **Obsolete**

**Modeled**  
- Status ini berarti objek bisnis/komponen objek bisnis telah didefinisikan.

**Implemented**  
- Status ini berarti objek bisnis/komponen objek bisnis telah memiliki fungsionalitas penuh yang diimplementasikan.
- Dapat digunakan untuk tujuan internal (dalam SAP) dan tujuan pengujian.

**Released**  
- Status ini berarti objek bisnis/komponen objek bisnis memiliki fungsionalitas penuh dan antarmuka telah dibekukan.
- Ini akan membuat entri di BAPI Explorer dan dapat dipanggil dari aplikasi eksternal juga (Non-SAP).

**Obsolete**  
- Status ini berarti objek bisnis/komponen objek bisnis tidak dapat digunakan.

**Fungsi (Manfaat) Objek Bisnis**  
- Di level BO, sistem Non-SAP dapat berkomunikasi dengan sistem SAP menggunakan BAPI.
- Jenis BO berfungsi sebagai titik masuk data dan fungsi untuk sistem SAP.
- BO dapat digunakan dalam alur bisnis, ALE, dll.

**Tabel Terkait Objek Bisnis**  
- Tabel untuk repositori objek bisnis (BOR) data dasar: **TOJTB**
- Tabel untuk informasi detail objek bisnis: **SWOTLV**

**IDOC’s - Pengenalan**  
- IDOC adalah singkatan dari **Intermediate Documents**.
- IDOC adalah wadah data (file data) yang dipertukarkan antara dua sistem atau dua proses.
- Setiap IDOC memiliki nomor unik.

**Proses IDOC**  
- Ada 2 jenis proses IDOC:
  1. **Proses inbound**
  2. **Proses outbound**

**Proses Inbound**  
- Jika data datang ke sistem SAP, itu disebut sebagai proses inbound.

**Proses Outbound**  
- Jika data keluar dari sistem SAP, itu disebut sebagai proses outbound.

**Metode/Teknologi Pertukaran Data IDOC**  
- Ada 2 jenis metode/teknologi pertukaran data dalam IDOC:
  1. **ALE**
  2. **EDI**

**ALE**  
- ALE adalah teknologi proprietary SAP.
- ALE adalah singkatan dari **Application Link Enabling**.
- Jika format data tidak berubah antar sistem, itu disebut ALE.
- ALE selalu digunakan antara sistem SAP.

**EDI**  
- EDI adalah istilah yang lebih lama dan sudah ada jauh sebelum SAP.
- EDI adalah singkatan dari **Electronic Data Interchange**.
- Jika format data berubah antar sistem, itu disebut EDI.
- EDI digunakan antara SAP ke Non-SAP, Non-SAP ke SAP, dan SAP-SAP.

**Arsitektur IDOC**  
- Arsitektur IDOC memiliki 3 bagian:
  1. **Control record**
  2. **Data record**
  3. **Status record**

**Control Record**  
- Menyediakan informasi kontrol seperti tipe IDOC (basic type), tipe pesan, port, nomor partner, dll.
- Juga menyediakan arah (inbound, outbound) dari IDOC.
- Nilai 1 untuk IDOC outbound dan nilai 2 untuk IDOC inbound.
- Disimpan dalam tabel **EDIDC**.

**Data Record**  
- Menyediakan seluruh data IDOC.
- Data disimpan dalam segmen-segmen.
- Disimpan dalam tabel **EDID4**.

**Status Record**  
- Menyediakan status IDOC (berhasil / error).
- Nilai 1-42 untuk status IDOC outbound dan 50-75 untuk status IDOC inbound.

**Tipe Pesan**  
- Menentukan makna data.
- Memberitahu tujuan IDOC yang akan diproses.
- Contoh: Kami mentransfer data karyawan.
- Kode transaksi untuk tipe pesan adalah **WE81**.

**Tipe IDOC**  
- Juga disebut sebagai **Basic Type**.
- Menentukan struktur data yang akan dipertukarkan.
- Contoh: Saat mentransfer data karyawan, empid dan empname adalah contoh dari tipe IDOC.
- Kode transaksi untuk tipe IDOC adalah **WE30**.

**Perbedaan antara Tipe IDOC dan Tipe Pesan**  
- Tipe IDOC menentukan struktur data, sementara tipe pesan menentukan makna data.

**Segmen**  
- Segmen adalah elemen dasar dari tipe IDOC.
- Data disimpan dalam segmen-segmen.
- Kode transaksi untuk segmen adalah **WE31**.

**Antarmuka IDOC (ALE) untuk BAPI**  
- Kode transaksi untuk membuat antarmuka ALE untuk BAPI: **BDBG**
- Tabel untuk menyimpan antarmuka BAPI-ALE untuk pemrosesan inbound: **TBDBE**

**Pengaturan IDOC - Port**  
- Port mendefinisikan saluran teknis antara sistem pengirim dan penerima.
- Port dalam sistem SAP bertindak sebagai saluran komunikasi untuk mengirimkan IDOC.
- Kode transaksi untuk membuat port adalah **WE21**.

**Port TRFC**  
- TRFC adalah singkatan dari **Transactional Port**.
- Di sini kita mendefinisikan port untuk tujuan RFC yang dibuat menggunakan **SM59**.

**File Port**  
- Saat menggunakan file port, kita dapat menentukan direktori tempat file IDOC akan diletakkan.
- Sistem lain atau middleware akan mengambil file dari sini.

**Pengaturan IDOC - Profil Partner**  
- Partner adalah pihak yang kita lakukan bisnis dan pertukaran dokumen.
- Dalam profil partner, kita mengatur parameter yang diperlukan untuk pertukaran data.
- Kode transaksi untuk membuat profil partner adalah **WE20**.

**Sistem Logis**  
- Sistem logis digunakan untuk mengidentifikasi klien individual dalam sistem.
- Sistem logis adalah ID unik dalam sistem SAP yang mengidentifikasi sistem komunikasi partner.
- Kode transaksi untuk sistem logis adalah **BD54**.

**Proses Kode**  
- Proses kode berisi detail modul fungsi yang digunakan untuk pemrosesan IDOC.
- Ada 2 jenis proses kode:
  1. **Proses inbound**
  2. **Proses outbound**

**Kode Proses Inbound**  
- Memproses IDOC dan mengirim data ke aplikasi.
- Kode transaksi untuk kode proses inbound adalah **WE42**.

**Kode Proses Outbound**  
- Mengambil data dari aplikasi dan mengirim IDOC.
- Kode transaksi untuk kode proses outbound adalah **WE41**.  


# ABAP-OOPS
**ABAP OOPS (Object Oriented Programming System)**

1) **Konsep OOPS**

   - **Class** -> Kumpulan objek (Methods, Attributes, Events, Interfaces).
   - **Object** -> Instance dari sebuah class.
   - **Inheritance** -> Membuat Subclass dari Parent class.
     - Konsep Inheritance memungkinkan kita membuat class baru dari class yang sudah ada.
     - Multiple Inheritance tidak dimungkinkan di ABAP, tetapi dapat dicapai dengan bantuan Interfaces.

   - **Polymorphism** -> Berbagai bentuk.
     - Polymorphism adalah karakteristik yang memungkinkan untuk menetapkan perilaku atau nilai yang berbeda dalam subclass terhadap sesuatu yang dideklarasikan di parent class.
     - Sebagai contoh, sebuah method dapat dideklarasikan di parent class, tetapi setiap subclass dapat memiliki implementasi yang berbeda untuk method tersebut.
	
   - **Encapsulation** -> Pengikatan data dan fungsi ke dalam satu unit (bentuk kapsul) -> Menyembunyikan data.

2) **Jenis-jenis Class**

   - **Global classes** -> Transaction code: SE24 (Class Builder), dapat digunakan kembali.
     - **Usual ABAP Class** -> Tujuannya adalah untuk menulis logika (sama dengan Function module dalam ABAP Core).
     - **Exception Class** -> Tujuannya adalah untuk menimbulkan dan menangani exception.
     - **Persistence Class** -> Tujuannya adalah untuk melakukan operasi database (Insert, Update, Delete).
     - **Unit Test Class** -> Tujuannya adalah untuk menulis unit test.
   - **Local Classes** -> Hanya untuk satu program, dapat dibuat dengan transaction code SE38.
     - Class Definition: Deklarasi.
     - Class Implementation: Logika.

3) **Level Method**

   - **Instance Method** -> Perlu membuat object untuk memanggil method tersebut.
   - **Static Method** -> Tidak perlu membuat object.

4) **Kontrol Visibilitas**
   
   - **Public**: Dapat diakses di dalam class, dalam Subclass, dan di luar class.
   - **Private**: Hanya dapat diakses di dalam class.
   - **Protected**: Dapat diakses di dalam class, dalam Subclass, tetapi tidak di luar class.

5) **Tipe Parameter dalam Class Method**:
   - **Importing** -> Input.
   - **Exporting** -> Output.
   - **Changing** -> Input/Output.
   - **Returning** -> Sebuah Method dapat memiliki beberapa parameter Exporting dan Changing, tetapi hanya satu parameter Returning.

6) **Deklarasi & Pembuatan Object**:

```abap
DATA: LO_OBJECT TYPE REF TO ZCL_TEST.

CREATE OBJECT LO_OBJECT.
```

   - **LO_OBJECT** = Nama object.
   - **ZCL_TEST** = Nama class.

**Q:** Bagaimana cara mendeklarasikan Static dan Instance Method dalam Local classes?

**A:** Instance Method: `Methods`, Static Method: `Class-Methods`.

**Q:** Bagaimana cara mendeklarasikan atribut Static dan Instance dalam Local classes?

**A:** Instance attribute: `DATA`, Static attribute: `CLASS-DATA`.

   Instance Method dapat mengakses atribut instance dan static.
   Static Method hanya dapat mengakses atribut static.

7) **FINAL Class** -> 

   - Class final adalah class yang tidak dapat diwarisi dan tidak dapat memiliki sub-class.

8) **Abstract Class** ->

   - Jenis khusus class yang memiliki minimal satu abstract method.
   - Abstract method adalah method yang hanya memiliki definisi tanpa implementasi.
   - Kita tidak dapat membuat objek dari Abstract Class, tetapi kita dapat membuat objek dari Subclass Abstract Class.

9) **Interface** ->

   - Dalam Interface, semua method secara default adalah public.
   - Dalam Interface, semua method adalah abstract method (hanya definisi, tidak ada implementasi).

10) **Perbedaan antara Abstract Class dan Interface**

   - **Abstract Class**:
     1) Memiliki minimal satu abstract method, yang lainnya bisa berupa non-abstract methods.
     2) Visibilitas method dapat berupa Public, Private, atau Protected.
     3) Kita perlu mendefinisikan ulang abstract method di subclass untuk mengimplementasikannya.
     4) Tidak mungkin melakukan Multiple Inheritance.

   - **Interface**:
     1) Semua method adalah abstract method.
     2) Semua method bersifat public.
     3) Tidak perlu mengklik tombol redefine (tombol redefine dinonaktifkan); kita dapat menulis logika di dalam class dengan mengklik dua kali method.
     4) Multiple Inheritance dimungkinkan.

**11) Events** -> Dengan metode ini, sebuah method dari satu class dapat memanggil method dari class lainnya.

- **Triggering Method** - yang akan menaikkan event.
- **Event Handler Method** -> yang akan menangani event tersebut.
- Daftarkan event handler method menggunakan pernyataan `SET HANDLER`.

   **Sintaks untuk Event Handler:**
   ```abap
   SET HANDLER lo_object1->event_handler FOR lo_object2.
   ```
   - **lo_object1** = Object class di mana event handler method didefinisikan.
   - **Event_handler** = Nama method event handler.
   - **lo_object2** = Object class di mana triggering method didefinisikan.

**Multiple Event Handlers**

---

**12) CONSTRUCTORS:**

1) Constructor adalah method khusus yang dieksekusi secara otomatis saat object dibuat.
2) Tidak dapat dipanggil menggunakan pernyataan `call method`.
3) Constructors adalah methods dengan nama yang telah ditentukan sebelumnya.
4) Tidak diizinkan memiliki multiple `CONSTRUCTOR` dan `CLASS_CONSTRUCTOR` dalam satu class.

   **Jenis-jenis Constructors:**
   - **CONSTRUCTOR (INSTANCE Constructor):**
     - Nama method: `CONSTRUCTOR`.
     - Hanya memiliki parameter Importing.
     - Dapat mengakses atribut static dan Instance.
     - Dipanggil setiap kali sebuah object dibuat.
     - Digunakan untuk mengatur nilai default untuk instance tertentu.
   
   - **CLASS_CONSTRUCTOR (STATIC Constructor):**
     - Nama method: `CLASS_CONSTRUCTOR`.
     - Tidak memiliki parameter.
     - Hanya dapat mengakses atribut static.
     - Dipanggil pertama kali saat object dibuat.

---

**13) Me Keyword** ->

   Sebuah method dapat memiliki variabel dengan nama yang sama seperti salah satu atribut class yang dimilikinya. Untuk mengidentifikasi atribut tingkat class dengan jelas, selector `ME` digunakan.

---

**14) Pengetahuan tambahan tentang Exception Class**

- Nama exception class harus dimulai dengan keyword `CX`.
- **CX_ROOT** adalah class global untuk semua exception.
- **CX_STATIC_CHECK** dan **CX_DYNAMIC_CHECK**.
- Gunakan blok **TRY** untuk menaikkan exception dan blok **CATCH** untuk menangani exception.

   **Sintaks untuk menaikkan Exception:**
   ```abap
   RAISE EXCEPTION TYPE (Exception Id).
   ```

---

**15) Pengetahuan tambahan tentang Persistence Class**

- Nama persistence class harus dimulai dengan keyword `CL`.
- 2 helper class secara otomatis dibuat: **CA** dan **CB**.
- **CA** disebut sebagai Actor class atau Agent class.
- **CB** disebut sebagai Base class.

---

**Method Overloading dan Method Overriding**

- **Method Overloading**:
   1) Terjadi dalam satu class.
   2) Dalam method overloading, methods harus memiliki nama yang sama tetapi dengan signature yang berbeda.
  
- **Method Overriding**:
   1) Dilakukan dalam dua class dengan hubungan inheritance (superclass dan subclass method).
   2) Dalam method overriding, methods harus memiliki nama dan signature yang sama.

   *Method Overloading tidak dimungkinkan dalam SAP ABAP OOPS.*

---

### ALV dengan Class `CL_GUI_ALV_GRID`

**Langkah-langkah Membuat ALV:**

1) **Langkah 1**: Buat Field Catalog.
   - Gunakan SAP Function Module (`LVC_FIELDCATALOG_MERGE`) untuk membuat field catalog, atau
   - Buat Field Catalog secara manual.

2) **Langkah 2**: Buat Custom Control (elemen layout) pada layar.

3) **Langkah 3**: Buat object dari Container class (`CL_GUI_CUSTOM_CONTAINER`).

4) **Langkah 4**: Buat object dari ALV GRID class (`CL_GUI_ALV_GRID`) dan berikan object dari container class pada parameter `parent`.

5) **Langkah 5**: Gunakan method `SET_TABLE_FOR_FIRST_DISPLAY` dari ALV GRID class (`CL_GUI_ALV_GRID`) untuk menampilkan data.

**2) Fitur ALV Non-Event Based di OOPS:**
   - Sorting, Filtering, dll.

**3) Fitur ALV Event Based di OOPS:**
   - Klik ganda, Klik HotSpot, dll.

---

### ALV dengan Class `CL_SALV_TABLE`

1) **CL_SALV_TABLE** adalah bagian dari model objek ALV.
2) Model objek ALV adalah enkapsulasi dari tools ALV yang sudah ada.
3) Contoh: `CL_SALV_TABLE` menggabungkan `CL_GUI_ALV_GRID` untuk implementasi container, serta function module `REUSE_ALV_GRID_DISPLAY` dan `REUSE_ALV_LIST_DISPLAY` untuk tampilan layar penuh.

   **Keuntungan Model Objek ALV**: Menyediakan antarmuka kolektif ke tools ALV.
   **Kelemahan Model Objek ALV**: Tidak memungkinkan ALV yang dapat diedit menggunakan model objek ALV.

**Langkah-langkah Membuat ALV dengan `CL_SALV_TABLE`:**

1) **Langkah 1**: Panggil method `FACTORY` dari `CL_SALV_TABLE` untuk mendapatkan instance dari object ALV table.
2) **Langkah 2**: Panggil method `DISPLAY` dari `CL_SALV_TABLE` untuk menampilkan ALV.

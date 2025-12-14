Siap 👍
Berikut **ISI `README.md` SIAP COPY–PASTE** sesuai **project kamu (Sistem Informasi Izin – JSP & MySQL)**.
👉 Langsung salin semuanya ke **README.md** lalu **Commit**.

---

```md
# 📄 Sistem Informasi Izin Siswa (JSP & MySQL)

![Java](https://img.shields.io/badge/Java-JSP-orange)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)

Project ini merupakan **Sistem Informasi Izin Siswa** berbasis **Java JSP dan MySQL** yang digunakan untuk mengelola data pengajuan izin siswa secara terstruktur dan terkomputerisasi.  
Project ini dibuat untuk **pembelajaran dan tugas kuliah**.

---

## 🎯 Fitur Aplikasi

### 👤 User
- Login & Logout
- Mengajukan izin siswa
- Melihat status izin (Pending / Approve / Reject)

### 🧑‍🏫 Admin / Guru
- Login admin
- Melihat daftar izin siswa
- Approve / Reject izin
- Filter data izin

---

## 🛠️ Teknologi yang Digunakan

- **Java JSP**
- **Servlet**
- **MySQL**
- **Apache Tomcat**
- **NetBeans IDE**
- **HTML, CSS**

---

## 🗂️ Struktur Project

```

izinsiswa/
│
├── Web Pages/
│   ├── META-INF/
│   ├── WEB-INF/
│   │   └── web.xml
│   │
│   ├── css/
│   │   ├── index.css
│   │   └── style.css
│   │
│   ├── database/
│   │   └── db_izin.sql
│   │
│   ├── admin.jpg
│   │
│   ├── add_guru.jsp
│   ├── add_siswa.jsp
│   ├── dashboard_siswa.jsp
│   ├── data_guru.jsp
│   ├── data_izin.jsp
│   ├── data_siswa.jsp
│   ├── delete_guru.jsp
│   ├── delete_siswa.jsp
│   ├── edit_guru.jsp
│   ├── edit_siswa.jsp
│   ├── form_izin.jsp
│   ├── index.jsp
│   ├── izin_list_siswa.jsp
│   ├── koneksi.jsp
│   ├── laporan.jsp
│   ├── login.jsp
│   ├── logout.jsp
│   ├── pengaturan.jsp
│   └── proseslogin.jsp
│
├── src/
│   └── (Java package / servlet jika ada)
│
├── nbproject/
├── build/
├── build.xml

````

---

## 🗄️ Database

### Nama Database
```sql
db_izin
````

### Tabel Utama

* `users`
* `siswa`
* `guru`
* `izin`
* `izin_siswa`

> Seluruh data yang digunakan adalah **data dummy (contoh)**.

---

## ⚙️ Cara Menjalankan Project

### 1️⃣ Import Database

1. Jalankan **XAMPP**
2. Aktifkan **MySQL**
3. Buka `http://localhost/phpmyadmin`
4. Buat database `db_izin`
5. Import file:

   ```
   database/db_izin.sql
   ```

---

### 2️⃣ Jalankan Aplikasi

1. Buka project di **NetBeans**
2. Jalankan di **Apache Tomcat**
3. Akses melalui browser:

   ```
   http://localhost:8080/izinsiswa
   ```

---

## 📚 Tujuan Project

* Latihan pengembangan aplikasi web berbasis Java
* Memahami konsep CRUD
* Penerapan database relasional
* Dokumentasi project menggunakan GitHub

---

## 👨‍💻 Author

**Dalpan Rohi**

---

## 📄 License

Project ini dibuat untuk **Educational Purpose** dan bebas digunakan untuk pembelajaran.

```

---


# 🚀 SISTEM INFORMASI IZIN SISWA
### Java JSP & MySQL

Aplikasi **Sistem Informasi Izin Siswa** berbasis **Java JSP dan MySQL** yang digunakan untuk mengelola proses perizinan siswa secara terkomputerisasi.  
Project ini dibuat untuk **keperluan tugas dan pembelajaran**.

---

## 🎯 Fitur Utama
- Login Admin
- Pengajuan izin siswa
- Persetujuan izin oleh admin
- Status izin (Pending / Approve / Reject)

---

## 🧠 Logika Program
1. Admin melakukan login melalui halaman login admin.
2. Setelah login berhasil, admin dapat mengelola data siswa, guru, dan izin.
3. Siswa mengajukan izin melalui form pengajuan izin.
4. Data izin disimpan ke database dengan status **Pending**.
5. Admin melakukan proses persetujuan izin:
   - **Approve** → izin disetujui
   - **Reject** → izin ditolak
6. Status izin dapat dilihat oleh admin dan siswa.

---

## 🛠️ Teknologi yang Digunakan
- Java JSP
- MySQL
- Apache Tomcat
- NetBeans IDE

---

## 🗄️ Database
**Nama Database:** `db_izin`

**Tabel Utama:**
- `users` (admin)
- `siswa`
- `tbl_guru`
- `izin_siswa`

> Seluruh data yang digunakan adalah **data dummy (contoh)** dan digunakan untuk pembelajaran.

---

## ⚙️ Cara Menjalankan Aplikasi
1. Import database `db_izin.sql` ke **phpMyAdmin**
2. Jalankan project menggunakan **Apache Tomcat**
3. Akses aplikasi melalui browser:
http://localhost:8080/izinsiswa



---

## 👨‍💻 Author
**Dalpan Rohi**

---

## 📄 License
Project ini dibuat dan digunakan untuk **keperluan pembelajaran**.

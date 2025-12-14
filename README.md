
````md
# 📄 Sistem Informasi Izin Siswa (JSP & MySQL)

![Java](https://img.shields.io/badge/Java-JSP-orange)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)

Aplikasi **Sistem Informasi Izin Siswa** berbasis **Java JSP dan MySQL** untuk mengelola pengajuan izin siswa secara terkomputerisasi.  
Project ini dibuat untuk **pembelajaran dan tugas kuliah**.

---

## 🎯 Fitur Utama

- Login & Logout
- Pengajuan izin siswa
- Persetujuan izin oleh admin/guru
- Status izin (Pending / Approve / Reject)

---

## 🛠️ Teknologi

- Java JSP & Servlet  
- MySQL  
- Apache Tomcat  
- NetBeans IDE  
- HTML & CSS  

---

## 📸 Tampilan Website

> Berikut beberapa tampilan dari aplikasi:

### Halaman Login
<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/b8719b3f-e6bd-41ab-b0db-a181271e4604" />


### Dashboard
![Dashboard](screenshots/dashboard.png)

### Data Izin
![Data Izin](screenshots/data_izin.png)

---

## 🗄️ Database

### Nama Database
```sql
db_izin
````

### Tabel Utama

* `users`
* `siswa`
* `tbl_guru`
* `izin_siswa`

> Seluruh data yang digunakan adalah **data dummy (contoh)**.

---

## ⚙️ Cara Menjalankan

1. Jalankan **XAMPP** dan aktifkan **MySQL**
2. Buka `phpMyAdmin`
3. Buat database `db_izin`
4. Import file:

   ```
   database/db_izin.sql
   ```
5. Jalankan project di **Apache Tomcat**
6. Akses melalui browser:

   ```
   http://localhost:8080/izinsiswa
   ```

---

## 👨‍💻 Author

**Dalpan Rohi**

---

## 📄 License

Project ini dibuat untuk **Educational Purpose**.

```

---

## 📌 Catatan Penting (WAJIB)
Buat folder ini di project kamu:
```

screenshots/

```

Isi dengan file:
- `login.png`
- `dashboard.png`
- `data_izin.png`

Jika nama file **tidak sama**, gambar **tidak akan muncul**.

---

Kalau mau, saya bisa:
- Menyesuaikan README dengan **foto asli websitemu**
- Membuat versi **lebih singkat lagi**
- Mengecek **apakah gambar sudah tampil di GitHub**

Tinggal bilang 👍
```

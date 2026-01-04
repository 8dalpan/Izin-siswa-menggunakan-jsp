<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>
<%
if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

%>

<!DOCTYPE html>
<html>
<head>
    <title>Tambah Data Guru</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="form-box">
    <h2>Tambah Data Guru</h2>

    <form method="post">
        <label>Nama Guru</label>
        <input type="text" name="nama_guru" required>

        <label>NIP</label>
        <input type="text" name="nip" required>

        <label>Mata Pelajaran</label>
        <input type="text" name="mapel" required>

        <label>Jenis Kelamin</label>
        <select name="jenis_kelamin" required>
            <option value="">-- Pilih Jenis Kelamin --</option>
            <option value="Laki-laki">Laki-laki</option>
            <option value="Perempuan">Perempuan</option>
        </select>

        <label>No HP</label>
        <input type="text" name="no_hp" required>

        <label>Alamat</label>
        <textarea name="alamat" required></textarea>

        <div class="btn-group">
            <button type="submit" name="save" class="btn-submit">Simpan</button>
            <a href="data_guru.jsp" class="btn-back">Kembali</a>
        </div>
    </form>
</div>

</body>
</html>

<%
/* ===============================
   PROSES SIMPAN DATA
================================ */
if (request.getParameter("save") != null) {

    String nama = request.getParameter("nama_guru");
    String nip = request.getParameter("nip");
    String mapel = request.getParameter("mapel");
    String jk = request.getParameter("jenis_kelamin");
    String noHp = request.getParameter("no_hp");
    String alamat = request.getParameter("alamat");

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO tbl_guru (nama_guru, nip, mapel, jenis_kelamin, no_hp, alamat) VALUES (?,?,?,?,?,?)"
    );

    ps.setString(1, nama);
    ps.setString(2, nip);
    ps.setString(3, mapel);
    ps.setString(4, jk);
    ps.setString(5, noHp);
    ps.setString(6, alamat);

    ps.executeUpdate();

    out.println("<script>alert('Data guru berhasil disimpan'); window.location='data_guru.jsp';</script>");
}
%>

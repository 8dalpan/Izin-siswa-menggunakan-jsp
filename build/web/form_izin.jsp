<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="koneksi.jsp" %>

<%
if (session.getAttribute("id_siswa") == null ||
    !"siswa".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pengajuan Izin Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="form-box">
    <h2>Pengajuan Izin Siswa</h2>

    <form method="post"
          action="uploadIzin"
          enctype="multipart/form-data">

        <label>Jenis Izin</label>
        <select name="jenis" required>
            <option value="">-- Pilih --</option>
            <option>Sakit</option>
            <option>Pulang</option>
            <option>Terlambat</option>
            <option>Keperluan Keluarga</option>
        </select>

        <label>Alasan</label>
        <textarea name="alasan" required></textarea>

        <label>Tanggal Mulai</label>
        <input type="date" name="mulai" required>

        <label>Tanggal Kembali</label>
        <input type="date" name="kembali">

        <label>Bukti Izin (Opsional)</label>
        <input type="file" name="bukti" accept=".pdf,.jpg,.jpeg,.png">

        <div class="btn-group">
            <button class="btn-submit">Ajukan</button>
            <a href="dashboard_siswa.jsp" class="btn-back">Kembali</a>
        </div>
    </form>
</div>

</body>
</html>

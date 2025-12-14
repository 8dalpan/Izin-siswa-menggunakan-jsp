<%@ include file="koneksi.jsp" %>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

%>
<!DOCTYPE html>
<html>
<head>
    <title>Tambah Data Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="form-box">


    <h2>Tambah Data Siswa</h2>

    <form method="post">

        <label>Nama Siswa</label>
        <input type="text" name="nama" placeholder="Masukkan nama siswa" required>

        <label>NIS</label>
        <input type="text" name="nis" placeholder="Nomor Induk Siswa" required>

        <label>Kelas</label>
        <input type="text" name="kelas" placeholder="Contoh: 10-A" required>

        <div class="btn-group">
            <button type="submit" name="simpan" class="btn-submit">Simpan</button>
            <a href="data_siswa.jsp" class="btn-back">Kembali</a>
        </div>

    </form>

</div>

<%
if(request.getParameter("simpan") != null){

    String nama = request.getParameter("nama");
    String nis = request.getParameter("nis");
    String kelas = request.getParameter("kelas");
    String id_user = request.getParameter("id_user");

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO siswa (id_user, nama, password, nis, kelas) VALUES (?,?,?,?,?)"
    );

    // SET PARAMETER SESUAI URUTAN QUERY
    // 1. id_user
    if(id_user == null || id_user.equals("")){
        ps.setNull(1, java.sql.Types.INTEGER);
    } else {
        ps.setInt(1, Integer.parseInt(id_user));
    }

    // 2. nama
    ps.setString(2, nama);

    // 3. password = default NIS
    ps.setString(3, nis);

    // 4. nis
    ps.setString(4, nis);

    // 5. kelas
    ps.setString(5, kelas);

    ps.executeUpdate();

    out.println("<script>alert('Data siswa berhasil disimpan!'); window.location='add_siswa.jsp';</script>");
}
%>

</body>
</html>

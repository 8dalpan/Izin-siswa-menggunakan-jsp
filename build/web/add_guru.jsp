<%@ include file="koneksi.jsp" %>
<%
if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

%>
<link rel="stylesheet" href="css/style.css">

<div class="form-box">
   

<h2>Tambah Data Guru</h2>

<form method="post">

    <label>Nama Guru:</label>
    <input type="text" name="nama_guru" required>

    <label>NIP:</label>
    <input type="text" name="nip" required>

    <label>Mapel:</label>
    <input type="text" name="mapel" required>

    <label>Jenis Kelamin:</label>
    <select name="jenis_kelamin" required>
        <option value="">-- Pilih Jenis Kelamin --</option>
        <option value="Laki-laki">Laki-laki</option>
        <option value="Perempuan">Perempuan</option>
    </select>

    <label>No HP:</label>
    <input type="text" name="no_hp" required>

    <label>Alamat:</label>
    <textarea name="alamat" required></textarea>
<div class="btn-group">
    <button type="submit" name="save" class="btn-submit">Simpan</button>
    <a href="data_guru.jsp" class="btn-back">Kembali</a>
</div>

</form>
</div>


<%
if (request.getParameter("save") != null) {

    String nama = request.getParameter("nama_guru");
    String nip = request.getParameter("nip");
    String mapel = request.getParameter("mapel");

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO tbl_guru (nama_guru, nip, mapel) VALUES (?,?,?)"
    );

    ps.setString(1, nama);
    ps.setString(2, nip);
    ps.setString(3, mapel);
    ps.executeUpdate();

      out.println("<script>alert('Data guru berhasil disimpan'); window.location='data_guru.jsp';</script>");
}
%>

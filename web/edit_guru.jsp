<%@ include file="koneksi.jsp" %>
<%@ page import="java.sql.*" %>

<%
/* ===============================
   SECURITY: ADMIN ONLY
================================ */
if (session.getAttribute("role") == null ||
    !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}

/* ===============================
   VALIDASI PARAMETER
================================ */
String param = request.getParameter("id_guru");
if (param == null) {
    response.sendRedirect("data_guru.jsp");
    return;
}
int id = Integer.parseInt(param);

/* ===============================
   AMBIL DATA GURU
================================ */
PreparedStatement ps = conn.prepareStatement(
    "SELECT * FROM tbl_guru WHERE id_guru=?"
);
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();

if (!rs.next()) {
    out.println("Data guru tidak ditemukan");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Data Guru</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="form-box">
    <h2>Edit Data Guru</h2>

    <form method="post">
        <input type="hidden" name="id_guru" value="<%= id %>">

        <label>Nama Guru</label>
        <input type="text" name="nama_guru"
               value="<%= rs.getString("nama_guru") %>" required>

        <label>NIP</label>
        <input type="text" name="nip"
               value="<%= rs.getString("nip") %>" required>

        <label>Mata Pelajaran</label>
        <input type="text" name="mapel"
               value="<%= rs.getString("mapel") %>" required>

        <label>Jenis Kelamin</label>
        <select name="jenis_kelamin" required>
            <option value="Laki-laki"
                <%= "Laki-laki".equals(rs.getString("jenis_kelamin")) ? "selected" : "" %>>
                Laki-laki
            </option>
            <option value="Perempuan"
                <%= "Perempuan".equals(rs.getString("jenis_kelamin")) ? "selected" : "" %>>
                Perempuan
            </option>
        </select>

        <label>No HP</label>
        <input type="text" name="no_hp"
               value="<%= rs.getString("no_hp") %>">

        <label>Alamat</label>
        <textarea name="alamat"><%= rs.getString("alamat") %></textarea>

        <div class="btn-group">
            <button type="submit" name="update" class="btn-submit">
                Update
            </button>
            <a href="data_guru.jsp" class="btn-back">
                Kembali
            </a>
        </div>
    </form>
</div>

<%
/* ===============================
   PROSES UPDATE
================================ */
if (request.getParameter("update") != null) {

    PreparedStatement up = conn.prepareStatement(
        "UPDATE tbl_guru SET " +
        "nama_guru=?, nip=?, mapel=?, jenis_kelamin=?, no_hp=?, alamat=? " +
        "WHERE id_guru=?"
    );

    up.setString(1, request.getParameter("nama_guru"));
    up.setString(2, request.getParameter("nip"));
    up.setString(3, request.getParameter("mapel"));
    up.setString(4, request.getParameter("jenis_kelamin"));
    up.setString(5, request.getParameter("no_hp"));
    up.setString(6, request.getParameter("alamat"));
    up.setInt(7, Integer.parseInt(request.getParameter("id_guru")));

    up.executeUpdate();

  out.println("<script>alert('Data guru berhasil diedit'); window.location='data_guru.jsp';</script>");
}
%>

</body>
</html>

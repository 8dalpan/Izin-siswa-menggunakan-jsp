<%@ include file="koneksi.jsp" %>
<%@ page import="java.sql.*" %>

<%
if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}

int id = Integer.parseInt(request.getParameter("id_siswa"));

PreparedStatement ps = conn.prepareStatement(
    "SELECT * FROM siswa WHERE id_siswa=?"
);
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="form-box">
    <h2>Edit Data Siswa</h2>

    <form method="post">
        <input type="hidden" name="id_siswa" value="<%= id %>">

        <label>Nama</label>
        <input type="text" name="nama" value="<%= rs.getString("nama") %>" required>

        <label>NIS</label>
        <input type="text" name="nis" value="<%= rs.getString("nis") %>" required>

        <label>Kelas</label>
        <input type="text" name="kelas" value="<%= rs.getString("kelas") %>" required>

        <div class="btn-group">
            <button type="submit" name="update" class="btn-submit">Update</button>
            <a href="data_siswa.jsp" class="btn-back">Kembali</a>
        </div>
    </form>
</div>

<%
if (request.getParameter("update") != null) {
    PreparedStatement up = conn.prepareStatement(
        "UPDATE siswa SET nama=?, nis=?, kelas=? WHERE id_siswa=?"
    );

    up.setString(1, request.getParameter("nama"));
    up.setString(2, request.getParameter("nis"));
    up.setString(3, request.getParameter("kelas"));
    up.setInt(4, Integer.parseInt(request.getParameter("id_siswa")));

    up.executeUpdate();
    response.sendRedirect("data_siswa.jsp");
}
%>

</body>
</html>

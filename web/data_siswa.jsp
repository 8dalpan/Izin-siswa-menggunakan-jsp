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
    <title>Data Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="main">

<h2>Data Siswa</h2>
<a href="add_siswa.jsp" class="btn-back">+ Tambah Siswa</a>

<table>
<tr>
    <th>No</th>
    <th>NIS</th>
    <th>Nama</th>
    <th>Kelas</th>
    <th>Aksi</th>
</tr>

<%
    int no = 1;
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM siswa ORDER BY nama ASC");

    while(rs.next()){
%>

<tr style="text-align: center">
    <td><%= no++ %></td>
    <td><%= rs.getString("nis") %></td>
    <td><%= rs.getString("nama") %></td>
    <td><%= rs.getString("kelas") %></td>

    <td>
        <a href="edit_siswa.jsp?id_siswa=<%= rs.getInt("id_siswa") %>" class="btn-edit">Edit</a>
        <a href="delete_siswa.jsp?id_siswa=<%= rs.getInt("id_siswa") %>" 
           class="btn-delete"
           onclick="return confirm('Hapus siswa ini?')">Hapus</a>
    </td>
</tr>

<%
    }
%>

</table>
<br>
<a href="index.jsp" class="btn-back">Kembali</a>
</div>

</body>
</html>

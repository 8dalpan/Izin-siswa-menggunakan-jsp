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
%>

<link rel="stylesheet" href="css/style.css">

<div class="main">

    <h2>Daftar Guru</h2>

    <a href="add_guru.jsp" class="btn-back">+ Tambah Guru</a>

    <table style="margin-top: 25px;">
        <tr>
            <th>No.</th>
            <th>Nama Guru</th>
            <th>NIP</th>
            <th>Mapel</th>
            <th>Jenis Kelamin</th>
            <th>No HP</th>
            <th>Alamat</th>
            <th>Aksi</th>
        </tr>

        <%
            int no = 1;
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM tbl_guru");

            while (rs.next()) {
        %>

        <tr style="text-align: center">
            <td><%= no++ %></td>
            <td><%= rs.getString("nama_guru") %></td>
            <td><%= rs.getString("nip") %></td>
            <td><%= rs.getString("mapel") %></td>
            <td><%= rs.getString("jenis_kelamin") %></td>
              <td><%= rs.getString("no_hp") %></td>
                <td><%= rs.getString("alamat") %></td>
            <td>
                <a href="edit_guru.jsp?id_guru=<%= rs.getInt("id_guru") %>"
                   class="btn-edit">
                   Edit
                </a>

                <a href="delete_guru.jsp?id_guru=<%= rs.getInt("id_guru") %>"
                   class="btn-delete"
                   onclick="return confirm('Yakin ingin menghapus data ini?');">
                   Hapus
                </a>
            </td>
        </tr>

        <%
            }
            rs.close();
            st.close();
        %>
    </table>

    <br>
    <a href="index.jsp" class="btn-back">Kembali</a>

</div>

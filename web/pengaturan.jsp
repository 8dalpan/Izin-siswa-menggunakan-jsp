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

int idAdmin = (int) session.getAttribute("id_user");
String namaAdmin = (String) session.getAttribute("nama");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pengaturan Akun</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="form-box">
    <h2>Pengaturan Akun</h2>

    <form method="post">

        <label>Nama Admin</label>
        <input type="text" name="nama" value="<%= namaAdmin %>" required>

        <label>Password Baru</label>
        <input type="password" name="password"
               placeholder="Kosongkan jika tidak ingin mengubah password">

        <div class="btn-group">
            <button type="submit" name="simpan" class="btn-submit">
                Simpan Perubahan
            </button>
            <a href="index.jsp" class="btn-back">Kembali</a>
        </div>

    </form>
</div>

<%
/* ===============================
   PROSES UPDATE AKUN
================================ */
if (request.getParameter("simpan") != null) {

    String nama = request.getParameter("nama");
    String password = request.getParameter("password");

    if (password != null && !password.equals("")) {
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE users SET nama=?, password=? WHERE id_user=?"
        );
        ps.setString(1, nama);
        ps.setString(2, password);
        ps.setInt(3, idAdmin);
        ps.executeUpdate();
    } else {
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE users SET nama=? WHERE id_user=?"
        );
        ps.setString(1, nama);
        ps.setInt(2, idAdmin);
        ps.executeUpdate();
    }

    session.setAttribute("nama", nama);

    out.println("<script>alert('Pengaturan akun berhasil diperbarui'); "
              + "window.location='pengaturan.jsp';</script>");
}
%>

</body>
</html>

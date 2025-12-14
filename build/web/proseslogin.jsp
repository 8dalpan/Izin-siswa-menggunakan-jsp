<%@ include file="koneksi.jsp" %>
<%@ page import="java.sql.*" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

// Validasi input
if(username == null || password == null ||
   username.trim().isEmpty() || password.trim().isEmpty()) {

    out.println("<script>alert('Username dan password wajib diisi'); window.location='login.jsp';</script>");
    return;
}

///////////////////////////////////////////////////////////
// 1. CEK LOGIN ADMIN
///////////////////////////////////////////////////////////
PreparedStatement psAdmin = conn.prepareStatement(
    "SELECT * FROM users WHERE username=? AND password=?"
);
psAdmin.setString(1, username);
psAdmin.setString(2, password);

ResultSet rsAdmin = psAdmin.executeQuery();

if (rsAdmin.next()) {

    if (!"admin".equalsIgnoreCase(rsAdmin.getString("role"))) {
        out.println("<script>alert('Akses ditolak'); window.location='login.jsp';</script>");
        return;
    }

    session.setAttribute("id_user", rsAdmin.getInt("id_user"));
    session.setAttribute("nama", rsAdmin.getString("nama"));
    session.setAttribute("role", "admin");

    rsAdmin.close();
    psAdmin.close();

    response.sendRedirect("index.jsp");
    return;
}

///////////////////////////////////////////////////////////
// 2. CEK LOGIN SISWA
///////////////////////////////////////////////////////////
PreparedStatement psSiswa = conn.prepareStatement(
    "SELECT * FROM siswa WHERE nis=? AND password=?"
);
psSiswa.setString(1, username);
psSiswa.setString(2, password);

ResultSet rsSiswa = psSiswa.executeQuery();

if (rsSiswa.next()) {

    session.setAttribute("id_siswa", rsSiswa.getInt("id_siswa"));
    session.setAttribute("nama_siswa", rsSiswa.getString("nama"));
    session.setAttribute("role", "siswa");

    rsSiswa.close();
    psSiswa.close();

    response.sendRedirect("dashboard_siswa.jsp");
    return;
}

///////////////////////////////////////////////////////////
// 3. LOGIN GAGAL
///////////////////////////////////////////////////////////
out.println("<script>alert('Username atau password salah!'); window.location='login.jsp';</script>");
%>

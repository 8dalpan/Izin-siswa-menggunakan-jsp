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
    <title>Status Izin Saya</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        .izin-table {
            width: 85%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 14px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
        }
        table th, table td {
            vertical-align: middle;
        }
    </style>
</head>

<body>

<h2 style="text-align:center; margin-top:30px;">Status Pengajuan Izin Saya</h2>

<div class="izin-table">
<table class="table" border="1" cellpadding="10" cellspacing="0" width="100%">
    <thead>
        <tr style="background:#eef2ff;">
            <th>Jenis Izin</th>
            <th>Alasan</th>
            <th>Tanggal Mulai</th>
            <th>Tanggal Kembali</th>
            <th>Status</th>
        </tr>
    </thead>

    <tbody>
        <%
            int idSiswa = (session.getAttribute("id_siswa") != null) 
                            ? (int) session.getAttribute("id_siswa") 
                            : 0;

            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM izin_siswa WHERE id_siswa=? ORDER BY id_izin DESC"
            );
            ps.setInt(1, idSiswa);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                String status = rs.getString("status");
                String badge = "";
                String warna = "";

                if(status.equals("pending")){
                    badge = "Menunggu Verifikasi";
                    warna = "status-pending";
                } 
                else if(status.equals("disetujui")){
                    badge = "Disetujui";
                    warna = "status-approve";
                }
                else if(status.equals("ditolak")){
                    badge = "Ditolak";
                    warna = "status-reject";
                }
        %>

        <tr>
            <td><%= rs.getString("jenis_izin") %></td>
            <td><%= rs.getString("alasan") %></td>
            <td><%= rs.getString("tgl_mulai") %></td>
            <td><%= rs.getString("tgl_kembali") == null ? "-" : rs.getString("tgl_kembali") %></td>
            <td>
                <span class="<%= warna %>"><%= badge %></span>
            </td>
        </tr>

        <% } %>
    </tbody>

</table>

    <a href="dashboard_siswa.jsp" class="btn-back" style="margin-top:20px; display:inline-block;">Kembali</a>
</div>

</body>
</html>

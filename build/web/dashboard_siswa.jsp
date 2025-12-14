<%@ include file="koneksi.jsp" %>
<%
  if(session.getAttribute("role") == null || !"siswa".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}
 
    %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="main">

    <h2>Dashboard Siswa</h2>

    <!-- ===================== RINGKASAN STATUS IZIN ====================== -->
    <div class="cards">

        <%
            int idSiswa = (session.getAttribute("id_siswa") != null)
                           ? (int) session.getAttribute("id_siswa")
                           : 0;

            // Hitung pending
            PreparedStatement p1 = conn.prepareStatement("SELECT COUNT(*) FROM izin_siswa WHERE id_siswa=? AND status='pending'");
            p1.setInt(1, idSiswa);
            ResultSet r1 = p1.executeQuery();
            r1.next();
            int pending = r1.getInt(1);

            // Hitung disetujui
            PreparedStatement p2 = conn.prepareStatement("SELECT COUNT(*) FROM izin_siswa WHERE id_siswa=? AND status='disetujui'");
            p2.setInt(1, idSiswa);
            ResultSet r2 = p2.executeQuery();
            r2.next();
            int approve = r2.getInt(1);

            // Hitung ditolak
            PreparedStatement p3 = conn.prepareStatement("SELECT COUNT(*) FROM izin_siswa WHERE id_siswa=? AND status='ditolak'");
            p3.setInt(1, idSiswa);
            ResultSet r3 = p3.executeQuery();
            r3.next();
            int reject = r3.getInt(1);
        %>

        <div class="card">
            <div class="label">Menunggu Verifikasi</div>
            <div class="num"><%= pending %></div>
        </div>

        <div class="card">
            <div class="label">Izin Disetujui</div>
            <div class="num"><%= approve %></div>
        </div>

        <div class="card">
            <div class="label">Izin Ditolak</div>
            <div class="num"><%= reject %></div>
        </div>

        <div class="card">
            <div class="label">Ajukan Izin</div>
            <a href="form_izin.jsp" class="btn-add" style="margin-top:10px;">Ajukan</a>
        </div>

    </div>

    <!-- ===================== TABEL STATUS IZIN SISWA ====================== -->
    <div class="box">

        <h3 style="color:#0b4bff; margin-bottom:15px;">Status Pengajuan Izin</h3>

        <table>
            <thead>
                <tr>
                    <th>Jenis Izin</th>
                    <th>Alasan</th>
                    <th>Tgl Mulai</th>
                    <th>Tgl Kembali</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
                <%
                    PreparedStatement ps = conn.prepareStatement(
                        "SELECT * FROM izin_siswa WHERE id_siswa=? ORDER BY id_izin DESC"
                    );
                    ps.setInt(1, idSiswa);
                    ResultSet rs = ps.executeQuery();

                    while(rs.next()){
                        String st = rs.getString("status");
                        String badge = "";
                        String warna = "";

                        if(st.equals("pending")){
                            badge = "Menunggu";
                            warna = "status-pending";
                        } else if(st.equals("disetujui")){
                            badge = "Disetujui";
                            warna = "status-approve";
                        } else {
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

    </div>

</div>

</body>
</html>

<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>

<%

if (session.getAttribute("role") == null || 
    !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}

/* ===============================
   AMBIL FILTER
================================ */
String tglAwal  = request.getParameter("tgl_awal");
String tglAkhir = request.getParameter("tgl_akhir");
String status   = request.getParameter("status");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Laporan Izin Siswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="main">

    <h2>Laporan Izin Siswa</h2>

    <!-- FILTER -->
    <form method="get" class="filter-box">
        <input type="date" name="tgl_awal" value="<%= tglAwal != null ? tglAwal : "" %>">
        <input type="date" name="tgl_akhir" value="<%= tglAkhir != null ? tglAkhir : "" %>">

        <select name="status">
            <option value="">-- Semua Status --</option>
            <option value="pending"  <%= "pending".equals(status) ? "selected" : "" %>>Pending</option>
            <option value="disetujui" <%= "disetujui".equals(status) ? "selected" : "" %>>Disetujui</option>
            <option value="ditolak"   <%= "ditolak".equals(status) ? "selected" : "" %>>Ditolak</option>
        </select>

        <button type="submit" class="btn-filter">Tampilkan</button>
        <button type="button" onclick="window.print()" class="btn-filter">
            Cetak
        </button>
    </form>

    <!-- TABEL LAPORAN -->
    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Nama Siswa</th>
                <th>Jenis Izin</th>
                <th>Tanggal Mulai</th>
                <th>Tanggal Kembali</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>

        <%
        int no = 1;

        String sql =
            "SELECT s.nama, i.jenis_izin, i.tgl_mulai, i.tgl_kembali, i.status " +
            "FROM izin_siswa i " +
            "JOIN siswa s ON i.id_siswa = s.id_siswa " +
            "WHERE 1=1 ";

        if (tglAwal != null && !tglAwal.equals(""))
            sql += " AND DATE(i.tgl_mulai) >= ? ";

        if (tglAkhir != null && !tglAkhir.equals(""))
            sql += " AND DATE(i.tgl_mulai) <= ? ";

        if (status != null && !status.equals(""))
            sql += " AND i.status = ? ";

        PreparedStatement ps = conn.prepareStatement(sql);

        int idx = 1;
        if (tglAwal != null && !tglAwal.equals(""))
            ps.setString(idx++, tglAwal);

        if (tglAkhir != null && !tglAkhir.equals(""))
            ps.setString(idx++, tglAkhir);

        if (status != null && !status.equals(""))
            ps.setString(idx++, status);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String st = rs.getString("status");
        %>

        <tr style="text-align: center">
                <td><%= no++ %></td>
                <td><%= rs.getString("nama") %></td>
                <td><%= rs.getString("jenis_izin") %></td>
                <td><%= rs.getDate("tgl_mulai") %></td>
                <td><%= rs.getDate("tgl_kembali") %></td>
                <td>
                    <% if ("pending".equals(st)) { %>
                        <span class="status-pending">Pending</span>
                    <% } else if ("disetujui".equals(st)) { %>
                        <span class="status-approve">Disetujui</span>
                    <% } else { %>
                        <span class="status-reject">Ditolak</span>
                    <% } %>
                </td>
            </tr>

        <%
        }
        rs.close();
        ps.close();
        %>

        </tbody>
    </table>

    <br>
    <a href="index.jsp" class="btn-back">Kembali</a>

</div>

</body>
</html>

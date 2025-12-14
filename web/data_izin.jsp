<%@ include file="koneksi.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

%>
<%
    Connection connection = (Connection)application.getAttribute("koneksi");
    if(connection == null) connection = conn;

    // === FILTER LOGIC ===
    String fJenis = request.getParameter("jenis");
    String fStatus = request.getParameter("status");
    String fTanggal = request.getParameter("tanggal");

    String where = " WHERE 1=1 ";
    if(fJenis != null && !fJenis.equals("")) where += " AND jenis_izin='" + fJenis + "' ";
    if(fStatus != null && !fStatus.equals("")) where += " AND status='" + fStatus + "' ";
    if(fTanggal != null && !fTanggal.equals("")) where += " AND DATE(tgl_mulai)='" + fTanggal + "' ";

    // === HANDLE APPROVE / REJECT ===
    if(request.getParameter("action") != null){
        String act = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        PreparedStatement upd = connection.prepareStatement(
            "UPDATE izin_siswa SET status=?, waktu_persetujuan=NOW() WHERE id_izin=?"
        );
        upd.setString(1, act);
        upd.setInt(2, id);
        upd.executeUpdate();

        response.sendRedirect("data_izin.jsp");
        return;
    }

    // === QUERY TABLE ===
    Statement st = connection.createStatement();
    ResultSet rs = st.executeQuery(
        "SELECT izin_siswa.*, siswa.nama AS nama_siswa, siswa.kelas " +
        "FROM izin_siswa LEFT JOIN siswa ON izin_siswa.id_siswa = siswa.id_siswa " +
        where + " ORDER BY waktu_pengajuan DESC"
    );
%>

<!DOCTYPE html>
<html>
<head>
    <title>Data Izin Siswa</title>
    <link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="main">


<h2>Data Izin Siswa</h2>

<!-- FILTER FORM -->
<div class="filter-box">
<form method="get">
    Jenis: 
    <select name="jenis">
        <option value="">-- semua --</option>
        <option value="Sakit">Sakit</option>
        <option value="Pulang">Pulang</option>
        <option value="Terlambat">Terlambat</option>
        <option value="Keperluan Keluarga">Keperluan Keluarga</option>
    </select>

    Status:
    <select name="status">
        <option value="">-- semua --</option>
        <option value="pending">Pending</option>
        <option value="disetujui">Disetujui</option>
        <option value="ditolak">Ditolak</option>
    </select>

    Tanggal:
    <input type="date" name="tanggal">

    <button type="submit" class="btn-filter">Filter</button>
</form>
</div>

<table>
<tr>
    <th>No</th>
    <th>Siswa</th>
    <th>Kelas</th>
    <th>Jenis Izin</th>
    <th>Alasan</th>
    <th>Tanggal</th>
    <th>Status</th>
    <th>Bukti</th>
    <th>Aksi</th>
</tr>

<%
int no = 1;
while(rs.next()){
    String stts = rs.getString("status");
%>
<tr>
    <td><%= no++ %></td>
    <td><%= rs.getString("nama_siswa") %></td>
    <td><%= rs.getString("kelas") %></td>
    <td><%= rs.getString("jenis_izin") %></td>
    <td><%= rs.getString("alasan") %></td>
    <td><%= rs.getTimestamp("tgl_mulai") %></td>

    <td>
        <% if(stts.equals("pending")) { %>
            <span class="pending">Menunggu</span>
        <% } else if(stts.equals("disetujui")) { %>
            <span class="status-approve">Disetujui</span>
        <% } else { %>
            <span class="status-reject">Ditolak</span>
        <% } %>
    </td>

    <td>
    <%
String bukti = rs.getString("bukti");
if(bukti != null){
%>
<a href="downloadBukti?file=<%= bukti %>" target="_blank">
    Lihat Bukti
</a>

<%
} else {
%>
-
<%
}
    %>
        </td>   
    <td>
        <% if(stts.equals("pending")) { %>
            <a class="btn approve" href="data_izin.jsp?action=disetujui&id=<%= rs.getInt("id_izin") %>">Setujui</a>
            <a class="btn reject" href="data_izin.jsp?action=ditolak&id=<%= rs.getInt("id_izin") %>">Tolak</a>
        <% } else { %>
            <em>?</em>
        <% } %>
    </td>
</tr>
<%
}
%>

</table>
<br>
<div class="btn">
  <!-- BUTTON KEMBALI -->
<a href="index.jsp" class="btn-back">Kembali</a>  
</div>

</div>

</body>
</html>

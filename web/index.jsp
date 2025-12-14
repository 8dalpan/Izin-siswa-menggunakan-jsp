<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="koneksi.jsp" %>
<%
if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

%>
<%@ page import="java.sql.*, java.util.*" %>

<%


Connection connection = (Connection) application.getAttribute("koneksi");
if (connection == null) {
    connection = conn;
}

// ----------- Statistik utama -----------
int totalIzin = 0, approved = 0, pending = 0, rejected = 0;

try {
    Statement st = connection.createStatement();

    // Total izin
    ResultSet rt = st.executeQuery("SELECT COUNT(*) AS cnt FROM izin_siswa");
    if (rt.next()) totalIzin = rt.getInt("cnt");
    rt.close();

    // Status izin
    ResultSet rs = st.executeQuery("SELECT status, COUNT(*) AS cnt FROM izin_siswa GROUP BY status");
    while (rs.next()) {
        String s = rs.getString("status");
        int c = rs.getInt("cnt");

        if ("disetujui".equalsIgnoreCase(s)) approved = c;
        else if ("pending".equalsIgnoreCase(s)) pending = c;
        else if ("ditolak".equalsIgnoreCase(s)) rejected = c;
    }
    rs.close();
    st.close();

} catch (Exception e) {
    out.println("<div style='color:red'>Error: " + e.getMessage() + "</div>");
}

// ----------- Statistik jenis izin -----------
Map<String, Integer> jenisMap = new LinkedHashMap<>();

try {
    Statement s2 = connection.createStatement();
    ResultSet r2 = s2.executeQuery(
        "SELECT jenis_izin, COUNT(*) AS cnt FROM izin_siswa GROUP BY jenis_izin ORDER BY cnt DESC"
    );

    while (r2.next()) {
        jenisMap.put(r2.getString("jenis_izin"), r2.getInt("cnt"));
    }

    r2.close();
    s2.close();

} catch (Exception e) {}

// ----------- Statistik bulanan -----------
Map<String, Integer> bulanMap = new LinkedHashMap<>();
String[] namaBulan = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};

// Default 0 semua bulan
for (String b : namaBulan) bulanMap.put(b, 0);

try {
    PreparedStatement ps = connection.prepareStatement(
        "SELECT MONTH(tgl_mulai) AS m, COUNT(*) AS cnt " +
        "FROM izin_siswa WHERE YEAR(tgl_mulai)=YEAR(CURDATE()) " +
        "GROUP BY MONTH(tgl_mulai) ORDER BY m"
    );

    ResultSet rb = ps.executeQuery();
    while (rb.next()) {
        int m = rb.getInt("m");
        int c = rb.getInt("cnt");
        bulanMap.put(namaBulan[m - 1], c);
    }

    rb.close();
    ps.close();

} catch (Exception e) {}

// Convert bulanMap → string untuk Chart.js
String bulanLabel = "";
String bulanValue = "";
for (Map.Entry<String, Integer> e : bulanMap.entrySet()) {
    bulanLabel += "'" + e.getKey() + "',";
    bulanValue += e.getValue() + ",";
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Izin Siswa</title>
    <link rel="stylesheet" href="css/index.css">
</head>

<body>

<div class="wrapper">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <center>   <div class="logo">Izin Siswa</div></center>

        <nav class="nav">
            <a href="index.jsp" class="active">Dashboard</a>
            <a href="data_izin.jsp">Data Izin</a>
            <a href="data_siswa.jsp">Data Siswa</a>
            <a href="data_guru.jsp">Data Guru</a>
            <a href="laporan.jsp">Laporan</a>
            <a href="pengaturan.jsp">Pengaturan</a>
        </nav>

        <div style="flex:1"></div>

     <a href="logout.jsp" 
   onclick="return confirm('Apakah Anda ingin keluar?');" 
   style="padding:12px; background:#0b4bff; color:white; 
          text-align:center; border-radius:8px; display:block; text-decoration:none;">
    Logout
</a>


    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">

        <!-- HEADER -->
        <div class="header">
          
            <strong>Selamat Datang  Admin</strong>
        </div>

        <!-- STAT CARDS -->
        <div class="cards">
            <div class="card">
                <div class="label">Total Izin</div>
                <div class="num"><%= totalIzin %></div>
            </div>

            <div class="card">
                <div class="label">Izin Disetujui</div>
                <div class="num"><%= approved %></div>
            </div>

            <div class="card">
                <div class="label">Izin Pending</div>
                <div class="num"><%= pending %></div>
            </div>

            <div class="card">
                <div class="label">Izin Ditolak</div>
                <div class="num"><%= rejected %></div>
            </div>
        </div>

        <!-- GRID CONTENT -->
        <div class="content-grid">

            <!-- CHART -->
            <div class="box">
                <h3>Statistik Pengajuan Bulanan (Tahun Ini)</h3>

                <canvas id="chartBulanan" height="120"></canvas>

                <table style="width:100%; margin-top:20px;">
                    <tr>
                        <th style="text-align:left;">Bulan</th>
                        <th style="text-align:right;">Jumlah</th>
                    </tr>

                    <% for(Map.Entry<String,Integer> e : bulanMap.entrySet()) { %>
                        <tr>
                            <td><%= e.getKey() %></td>
                            <td style="text-align:right;"><%= e.getValue() %></td>
                        </tr>
                    <% } %>
                </table>
            </div>

            <!-- JENIS IZIN -->
            <div class="small-box">
                <h3>Jenis Izin Terbanyak</h3>
                <ul class="list-jenis">

                    <%
                        int sum = 0;
                        for(Integer v : jenisMap.values()) sum += v;

                        if(sum == 0){
                    %>
                        <li>Tidak ada data izin.</li>
                    <%
                        } else {
                            for(Map.Entry<String,Integer> e : jenisMap.entrySet()){
                                double pct = (e.getValue() * 100.0) / sum;
                    %>
                        <li>
                            <strong><%= e.getKey() %></strong> — <%= e.getValue() %>
                            (<%= String.format("%.0f", pct) %>%)
                        </li>
                    <%
                            }
                        }
                    %>

                </ul>
            </div>

        </div>

    </main>
</div>

<!-- CHART.JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
const ctx = document.getElementById("chartBulanan");

new Chart(ctx, {
    type: "line",
    data: {
        labels: [<%= bulanLabel %>],
        datasets: [{
            label: "Jumlah Izin",
            data: [<%= bulanValue %>],
            borderColor: "#0b4bff",
            backgroundColor: "rgba(11,75,255,0.25)",
            borderWidth: 3,
            tension: 0.4
        }]
    },
    options: { responsive: true }
});
</script>

</body>
</html>

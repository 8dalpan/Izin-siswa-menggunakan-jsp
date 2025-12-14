<%@ include file="koneksi.jsp" %>

<%
    // Ambil id_guru dari parameter URL
    int id = Integer.parseInt(request.getParameter("id_siswa"));

    // Query hapus guru berdasarkan id_guru
    PreparedStatement ps = conn.prepareStatement(
        "DELETE FROM siswa WHERE id_siswa=?"
    );
    ps.setInt(1, id);
    ps.executeUpdate();

    // Redirect kembali ke halaman daftar guru
    response.sendRedirect("data_siswa.jsp");
%>

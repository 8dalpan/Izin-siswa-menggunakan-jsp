<%@ include file="koneksi.jsp" %>

<%
    // Ambil id_guru dari parameter URL
    int id = Integer.parseInt(request.getParameter("id_guru"));

    // Query hapus guru berdasarkan id_guru
    PreparedStatement ps = conn.prepareStatement(
        "DELETE FROM tbl_guru WHERE id_guru=?"
    );
    ps.setInt(1, id);
    ps.executeUpdate();

    // Redirect kembali ke halaman daftar guru
    response.sendRedirect("data_guru.jsp");
%>

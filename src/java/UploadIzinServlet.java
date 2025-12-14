import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadIzin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class UploadIzinServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer idSiswa = (Integer) session.getAttribute("id_siswa");

        if (idSiswa == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String jenis   = request.getParameter("jenis");
        String alasan  = request.getParameter("alasan");
        String mulai   = request.getParameter("mulai");
        String kembali = request.getParameter("kembali");

        /* ===============================
           UPLOAD FILE
        =============================== */
        Part filePart = request.getPart("bukti");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" +
                       Paths.get(filePart.getSubmittedFileName()).getFileName();

            String uploadPath = "/home/dalpan/uploads_izin";
            File dir = new File(uploadPath);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);
        }

        /* ===============================
           KONEKSI DATABASE (AMAN)
        =============================== */
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/db_izin",
                "root",
                "27102005"
            );

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO izin_siswa " +
                "(id_siswa, jenis_izin, alasan, tgl_mulai, tgl_kembali, bukti, status, waktu_pengajuan) " +
                "VALUES (?,?,?,?,?, ?, 'pending', NOW())"
            );

            ps.setInt(1, idSiswa);
            ps.setString(2, jenis);
            ps.setString(3, alasan);
            ps.setString(4, mulai);
            ps.setString(5, kembali);
            ps.setString(6, fileName);

            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
            return;
        }

        response.sendRedirect("dashboard_siswa.jsp");
    }
}

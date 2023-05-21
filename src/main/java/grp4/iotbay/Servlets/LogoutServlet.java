package grp4.iotbay.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
<<<<<<< Updated upstream
=======
import java.sql.*;
>>>>>>> Stashed changes

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void service(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
<<<<<<< Updated upstream
        try {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
=======
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");
        long loginTime = (long) session.getAttribute("login_timestamp");

        Connection con = null;
        ResultSet rs = null;
        PreparedStatement ps = null;

        try {

            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
            );
            System.out.println("Delete Connected");

            String sql = "update u236601339_iotBay.access_logs set logout_timestamp=? where email=? and login_timestamp=?";

            ps = con.prepareStatement(sql);

            ps.setLong(1, System.currentTimeMillis());
            ps.setString(2, email);
            ps.setLong(3, loginTime);

            int count = ps.executeUpdate();
            if (count == 0) {
                response.sendRedirect("home.jsp");
            } else {
                session.removeAttribute("name");
                session.removeAttribute("email");
                session.removeAttribute("login_timestamp");
                session.removeAttribute("access_logs");
                session.invalidate();
                response.sendRedirect("");
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Logout Error! - " + e.getMessage());
>>>>>>> Stashed changes
        }
        finally {
            try {
                if(ps != null) {
                    ps.close();
                }
                if(rs != null) {
                    rs.close();
                }
                if(con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}

package grp4.iotbay;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void service(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");
        long loginTime = (long) session.getAttribute("login_timestamp");

        try {
            Connection con;

            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
            );
            System.out.println("Delete Connected");

            String sql = "update u236601339_iotBay.access_logs set logout_timestamp=? where email=? and login_timestamp=?";

            PreparedStatement ps = con.prepareStatement(sql);

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
        }
    }
}

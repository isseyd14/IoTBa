package grp4.iotbay.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/AccessLogServlet")
public class AccessLogServlet extends HttpServlet {
    @Override
    protected void service(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String email = (String) session.getAttribute("email");
      
        try{
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            System.out.println("Login Connected");

            String sql = "select * from u236601339_iotBay.access_logs where email=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, email);
            rs = ps.executeQuery();

            ArrayList<Long> loginTimes = new ArrayList<>();
            ArrayList<Long> logoutTimes = new ArrayList<>();
            while(rs.next()) {
                loginTimes.add(rs.getLong("login_timestamp"));
                logoutTimes.add(rs.getLong("logout_timestamp"));
            }
            session.setAttribute("login_times", loginTimes);
            session.setAttribute("logout_times", logoutTimes);
            response.sendRedirect("access_logs.jsp");
        }catch(Exception e){
            System.out.println("Access Log Error - " + e.getMessage());
        }
        finally {
            try {
                if(rs != null) {
                    rs.close();
                }
                if(ps != null) {
                    ps.close();
                }
                if(con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing db connection, result set or prepared set. - " + e.getMessage());
            }
        }
    }
}

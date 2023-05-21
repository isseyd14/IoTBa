package grp4.iotbay.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private void setSessionAttrs(HttpSession session, String email, String nameDB, int userIdDB) {
        session.setAttribute("email", email);
        session.setAttribute("name", nameDB);
        session.setAttribute("userId", userIdDB);
    }

    private void createUserLog(HttpSession session, Connection con, String email) throws SQLException {
        long loginTime = System.currentTimeMillis();
        session.setAttribute("login_timestamp", loginTime);

        // end timestamp for previous unlogged out session
        String sql = "update u236601339_iotBay.access_logs set logout_timestamp=? where email=? and logout_timestamp=-1";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setLong(1, loginTime);
        ps.setString(2, email);
        ps.executeUpdate();

        // create new session
        sql = "insert into u236601339_iotBay.access_logs (email, login_timestamp) values (?,?)";

        ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ps.setLong(2, loginTime);
        ps.executeUpdate();
    }

    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please enter a valid email or password.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            return;
        }
      
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
      
        try {
            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            System.out.println("Login Connected");

            String sql = "select * from u236601339_iotBay.users where email=? and password=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            String emailDB = "";
            String passwordDB = "";
            String typeDB = "";
            String nameDB = "";
            int userIdDB = 0;
            
            rs = ps.executeQuery();


            while(rs.next()) {
                emailDB = rs.getString("email");
                passwordDB = rs.getString("password");
                typeDB = rs.getString("Type");
                nameDB = rs.getString("name");
                userIdDB = rs.getInt("userID");

                System.out.println("emailDB: " + emailDB);
                System.out.println("passwordDB: " + passwordDB);
                System.out.println("nameDB: " + nameDB);
                System.out.println("userID: " + userIdDB);
            }

                if(email.equals(emailDB) && password.equals(passwordDB) && typeDB.equals("customer")){
                System.out.println("in If");

                HttpSession session = request.getSession();
                setSessionAttrs(session, email, nameDB, userIdDB);
                createUserLog(session, con, email);

                response.sendRedirect("home.jsp");
            } else if(email.equals(emailDB) && password.equals(passwordDB) && typeDB.equals("staff")) {

                HttpSession session = request.getSession();
                setSessionAttrs(session, email, nameDB, userIdDB);
                createUserLog(session, con, email);

                response.sendRedirect("staff-home.jsp");
            } else{
                System.out.println("in else");
                request.setAttribute("errorMessage", "Username or password incorrect. Try again.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        } catch(Exception e){
            System.out.println(" Login Error - " + e.getMessage());
        } finally {
            // Close statement and connection
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}


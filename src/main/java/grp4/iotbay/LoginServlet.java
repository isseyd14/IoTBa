package grp4.iotbay;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try{
            Connection con;

            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            System.out.println("Login Connected");

            String sql = "select * from u236601339_iotBay.users where email=? and password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            String emailDB = "";
            String passwordDB = "";
            String nameDB = "";

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
            emailDB = rs.getString("email");
            passwordDB = rs.getString("password");
            nameDB = rs.getString("name");

            System.out.println("emailDB: " + emailDB);
            System.out.println("passwordDB: " + passwordDB);
            System.out.println("nameDB: " + nameDB);
            }

            if(email.equals(emailDB) && password.equals(passwordDB)){
            System.out.println("in If");

            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("name", nameDB);

            long loginTime = System.currentTimeMillis();
            session.setAttribute("login_timestamp", loginTime);

            sql = "insert into u236601339_iotBay.access_logs (email, login_timestamp) values (?,?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setLong(2, loginTime);
            ps.executeUpdate();

            response.sendRedirect("home.jsp");
            }else{
            System.out.println("in else");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            }



        }catch(Exception e){
        System.out.println(" Login Error - " + e.getMessage());
        }
    }
}


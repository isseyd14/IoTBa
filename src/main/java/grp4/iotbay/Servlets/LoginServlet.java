package grp4.iotbay.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        // redirect to login page
    }
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please enter a valid email or password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Connection con = null;

        PreparedStatement ps = null;
        
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
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                emailDB = rs.getString("email");
                passwordDB = rs.getString("password");
                typeDB = rs.getString("Type");
                nameDB = rs.getString("name");

                System.out.println("emailDB: " + emailDB);
                System.out.println("passwordDB: " + passwordDB);
                        }

                if(email.equals(emailDB) && password.equals(passwordDB) && typeDB.equals("customer")){
                System.out.println("in If");

                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("name", nameDB);

                RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                rd.forward(request, response);
            }

            else if(email.equals(emailDB) && password.equals(passwordDB) && typeDB.equals("staff")) {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("name", nameDB);

                RequestDispatcher rd = request.getRequestDispatcher("staff-home.jsp");
                rd.forward(request,response);
            }

            else{
                request.setAttribute("errorMessage", "Username or password incorrect. Try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
            
        
        }catch(Exception e){
        System.out.println(" Login Error - " + e.getMessage());
        }
        finally {
            // Close statement and connection
            try {
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

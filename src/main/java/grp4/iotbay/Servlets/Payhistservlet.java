package grp4.iotbay;

import grp4.Model.Validators;
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
import grp4.Model.Payment;

@WebServlet("/Payhistservlet")
public class Payhistservlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
       Connection con = null;
        PreparedStatement ps = null;
        Payment pay =  (Payment) session.getAttribute("Oldpayment");


        try {
            if(pay == null){
                request.setAttribute("errorMessage1", "No Payment of this type");
            }
            
  
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "INSERT INTO u236601339_iotBay.PaymentInfo (CardNumber, CVC, Expdate,  Email, Name, orderID) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
          
            ps.executeUpdate();
           response.sendRedirect("home.jsp");
                        

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}

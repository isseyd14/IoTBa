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
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.*;

@WebServlet("/SearchpayServlet")
public class SearchpayServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Validators validator = new Validators();
        int payID = Integer.parseInt(request.getParameter("PayidSearch"));
        String CVC = request.getParameter("dateSearch");
        String currentEmail = (String) session.getAttribute("email");
        Connection con = null;
        PreparedStatement ps = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "select u236601339_iotBay.PaymentInfo Where = PaymentID ?" ;
            ps = con.prepareStatement(sql);
            ps.setInt(1,payID );
            ps.executeUpdate();
            response.sendRedirect("home.jsp");
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                Payment paymentNew = new Payment();
                paymentNew.setCreditCardNumber(rs.getString("CardNumber"));
                paymentNew.setEmail(rs.getString("Email"));
                paymentNew.setCreditCardExpiry(rs.getString("Expdate"));
                paymentNew.setCreditCardCVC(rs.getString("CVC"));
                paymentNew.setName(rs.getString("Name"));
                paymentNew.setCreated(rs.getTimestamp("Date"));
                paymentNew.setAmount(rs.getString("Amount"));
                session.setAttribute("PaymentN", paymentNew);
            
                //RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
                //rd.forward(request, response);
            }
            else {
                request.setAttribute("errorMessage", "No Payment of this type");
              //  RequestDispatcher rd = request.getRequestDispatcher("update-product.jsp");
               // rd.forward(request, response);
            }
                           
            }
        catch (Exception e) {
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


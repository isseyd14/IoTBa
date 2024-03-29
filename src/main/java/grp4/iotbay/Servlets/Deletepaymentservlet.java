package grp4.iotbay.Servlets;

import grp4.iotbay.Model.Validators;
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
import grp4.iotbay.Model.Payment;

@WebServlet("/Deletepaymentservlet")
public class Deletepaymentservlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentEmail = (String) session.getAttribute("email");
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "DELETE FROM u236601339_iotBay.PaymentInfo Where Email=?" ;
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            ps.executeUpdate();
            response.sendRedirect("account.jsp");
                            }

         catch (Exception e) {
            response.sendRedirect("account.jsp");

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
            response.sendRedirect("account.jsp");

                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}

package grp4.iotbay.Servlets;

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
import jakarta.servlet.RequestDispatcher;
import java.sql.ResultSet;

@WebServlet("/Payhistservlet")
public class Payhistservlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String currentEmail = (String) session.getAttribute("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "SELECT * FROM u236601339_iotBay.PaymentInfo WHERE Email=?" ;
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            rs = ps.executeQuery();
            if(rs.next()) {
                Payment paymentNew = new Payment();
                paymentNew.setCreditCardNumber(rs.getString("CardNumber"));
                paymentNew.setEmail(rs.getString("Email"));
                paymentNew.setCreditCardExpiry(rs.getString("Expdate"));
                paymentNew.setCreditCardCVC(rs.getString("CVC"));
                paymentNew.setName(rs.getString("Name"));
                session.setAttribute("PaymentN", paymentNew);
                RequestDispatcher rd = request.getRequestDispatcher("ViewPayList.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("errorMessage", "No Payment of this type");
            }
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
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}

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

@WebServlet("/UpdatePaymentServlet")
public class UpdatePaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Validators validator = new Validators();
        String CCN = request.getParameter("CCNE");
        String CVC = request.getParameter("CCCVC");
        String Expdate = request.getParameter("CCEE");
        String currentEmail = (String) session.getAttribute("email");
        int orderID = (int) session.getAttribute("orderID");
        String name = request.getParameter("Name");
        
        Payment pay =  (Payment) session.getAttribute("Oldpayment");
       Connection con = null;
        PreparedStatement ps = null;

        try {
            if(pay == null){
                session.setAttribute("CCMsg", "Please add payment information first");
                request.getRequestDispatcher("Addpayment.jsp").include(request, response);
            }
             if (!validator.validateCreditCardNumber(CCN)) {
                    session.setAttribute("CCMsg", "Credit card format incorrect, Please enter 16 digits");
                    request.getRequestDispatcher("Updatepayment.jsp").include(request, response);
                } else if (!validator.validateCreditCardExpiry(Expdate)) {
                    session.setAttribute("CCMsg", "Credit Card Expiry format incorrect, please eneter as mm/yy");
                    request.getRequestDispatcher("Updatepayment.jsp").include(request, response);
                } else if (!validator.validateCreditCardCVC(CVC)) {
                    session.setAttribute("CCMsg", "Credit Card CVC format incorrect, please enter 3 digits");
                    request.getRequestDispatcher("Updatepayment.jsp").include(request, response);
                }
            else{
                    
            Payment defaultpayment = new Payment(CCN , Expdate , CVC ,name  ,currentEmail);
            session.setAttribute("Oldpayment",defaultpayment);
            //session.setAttribute("Oldpayment",defaultpayment);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "Update u236601339_iotBay.PaymentInfo Set (CardNumber, CVC, Expdate, Name) VALUES (?, ?, ?, ?) Where orderID = ?" ;
            ps = con.prepareStatement(sql);
            ps.setString(1, CCN);
            ps.setString(2, CVC);
            ps.setString(3, Expdate);
            ps.setString(4, name);
            //ps.setString(5, orderID);
            ps.executeUpdate();
           response.sendRedirect("home.jsp");
                            }

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

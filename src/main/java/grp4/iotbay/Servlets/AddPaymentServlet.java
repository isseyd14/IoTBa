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
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.text.DateFormat;  
import java.util.Calendar;
import java.text.DateFormat;
import static java.time.LocalDate.now;
import java.util.Calendar;
import java.util.Date;

@WebServlet("/AddPaymentServlet")
public class AddPaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Validators validator = new Validators();
        String CCN = request.getParameter("CCNE");
        String CVC = request.getParameter("CCCVC");
        String Expdate = request.getParameter("CCEE");
        String currentEmail = (String) session.getAttribute("email");
        Double am = (Double) session.getAttribute("Amount");
        String amn = String.valueOf(am);     
        String name = request.getParameter("Name");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
             if (!validator.validateCreditCardNumber(CCN)) {
                    session.setAttribute("CCMsg", "Credit card format incorrect, Please enter 16 digits");
                    request.getRequestDispatcher("Addpayment.jsp").include(request, response);
                } else if (!validator.validateCreditCardExpiry(Expdate)) {
                    session.setAttribute("CCMsg", "Credit Card Expiry format incorrect, please eneter as mm/yy");
                    request.getRequestDispatcher("Addpayment.jsp").include(request, response);
                } else if (!validator.validateCreditCardCVC(CVC)) {
                    session.setAttribute("CCMsg", "Credit Card CVC format incorrect, please enter 3 digits");
                    request.getRequestDispatcher("Addpayment.jsp").include(request, response);
                }
                else{
          
                    
            Payment defaultpayment = new Payment(CCN , Expdate , CVC , name,  currentEmail);
            session.setAttribute("Oldpayment",defaultpayment);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql1 = ("SELECT Email FROM u236601339_iotBay.PaymentInfo WHERE Email = ?");
            ps = con.prepareStatement(sql1);
            ps.setString (1, currentEmail);
          
            rs = ps.executeQuery();
          
            if (rs.next()) {
                
                String sql = ("UPDATE u236601339_iotBay.PaymentInfo SET CardNumber = ?, CVC = ?, Expdate = ?, Name = ? WHERE Email = ?");
                ps = con.prepareStatement(sql);
                ps.setString(1, CCN);
                ps.setString(2, CVC);
                ps.setString(3, Expdate);
                ps.setString(4, name);
                ps.setString(5,currentEmail );
                ps.executeUpdate();
                ps.close();
            
            //response.sendRedirect("home.jsp"); 

                //response.sendRedirect("home.jsp");//cart checkout
            }
            else {
            String sql = "INSERT INTO u236601339_iotBay.PaymentInfo (CardNumber, CVC, Expdate,  Email, Name) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, CCN);
            ps.setString(2, CVC);
            ps.setString(3, Expdate);
            ps.setString(4, currentEmail);
            ps.setString(5, name);
            ps.executeUpdate();
            ps.close();

            //response.sendRedirect("home.jsp"); 
           }
            String sql = ("INSERT INTO u236601339_iotBay.Payment (Date, Email, Amount) VALUES (?, ?, ?)");
    
            DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

            String data = df.format(new Date());
          
            ps = con.prepareStatement(sql);
            ps.setString(1, data);
            ps.setString(2, currentEmail);
            ps.setString(3, amn);
            ps.executeUpdate();
            ps.close();

            response.sendRedirect("checkout.jsp"); 
                }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if(rs != null) {
                    rs.close();
                }
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

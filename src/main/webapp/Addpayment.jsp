<%-- 
    Document   : Addpayment
    Created on : 14 May 2023, 7:25:47 pm
    Author     : issey
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  
              
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add/update payment Details</title>
    </head>
    <body>
        <h1>IotBay</h1>
    </div>
          <%
        String CCNEr = (String) session.getAttribute("CCNE");
        String CCEEr = (String) session.getAttribute("CCEE");
        String CCCVCr = (String) session.getAttribute("CCCVC");
        String name = (String) session.getAttribute("Name");
        String email = (String) session.getAttribute("email");
        String CCM = (String) session.getAttribute("CCMsg");
Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
    %>    
    
    <%
        String currentEmail = (String) session.getAttribute("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "SELECT * FROM u236601339_iotBay.PaymentInfo WHERE Email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            rs = ps.executeQuery();
            //if(!rs.next()){
              //  request.setAttribute("errorMessage1", "No Payment of this type");  
          //  }
            }
                catch(SQLException e) {
        }
          

        %>
    <h2>Add/Update Payment</h2>
         <form action="AddPaymentServlet" method="post">
             <div>
    </div>  
             <%if(rs.next()){%>
              <table>
                <tr>
                    <td><label for="CCNE">Credit Card Number</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCNE" value=<%= rs.getString("CardNumber")%> required></td>
                </tr>
                <tr>
                    <td><label for="CCEE">Credit Card Expiry</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCEE" value = <%= rs.getString("Expdate")%> required></td>
                </tr>
                <tr>
                    <td><label for="CCCVC">Credit Card CVC</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCCVC" value = <%= rs.getString("CVC")%> required></td>
                </tr>
                 <tr>
                    <td><label for="Name">Name</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="Name" value = <%= rs.getString("Name")%> required></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                <center>
                    <p>${CCMsg}</p>
                    <input class="button" type="submit" value="Add/Confirm" required>
                </center>
                </td>
                </tr>
            </table><%} else{%>

             <table>
                <tr>
                    <td><label for="CCNE">Credit Card Number</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCNE" placeholder="<%=(CCNEr != null ? CCNEr : "0055435156548569")%>" required></td>
                </tr>
                <tr>
                    <td><label for="CCEE">Credit Card Expiry</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCEE" placeholder="<%=(CCEEr != null ? CCEEr : "12/24")%>" required></td>
                </tr>
                <tr>
                    <td><label for="CCCVC">Credit Card CVC</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCCVC" placeholder="<%=(CCCVCr != null ? CCCVCr : "161")%>" required></td>
                </tr>
                 <tr>
                    <td><label for="Name">Name</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="Name" placeholder="<%=(name != null ? name : "jack smith")%>" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                <center>
                    <p>${CCMsg}</p>
                    <input class="button" type="submit" value="Add/Confirm" required>
                </center>
                </td>
                </tr>
            </table>
             <%}%>
               
    </body>
</html>

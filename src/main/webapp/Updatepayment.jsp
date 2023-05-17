<%-- 
    Document   : Addpayment
    Created on : 14 May 2023, 7:25:47 pm
    Author     : issey
--%>

<%@ page import= "java.sql.*" %>
<%@ page import= "grp4.Model.Payment"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  
              
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add payment Details</title>
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
        Payment pay =  (Payment) session.getAttribute("Oldpayment");
    %>    
    <h2>Add Payment</h2>
         <form action="AddPaymentServlet" method="post">
             <div>
    </div>

             <table>
                <tr>
                    <td><label for="CCNE">Credit Card Number</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCNE" placeholder="<%=(CCNEr != null ? CCNEr : pay.getCreditNumber())%>" required></td>
                </tr>
                <tr>
                    <td><label for="CCEE">Credit Card Expiry</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCEE" placeholder="<%=(CCEEr != null ? CCEEr : pay.getCreditCardExpiry())%>" required></td>
                </tr>
                <tr>
                    <td><label for="CCCVC">Credit Card CVC</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="CCCVC" placeholder="<%=(CCCVCr != null ? CCCVCr : pay.getCreditCardCVC())%>" required></td>
                </tr>
                 <tr>
                    <td><label for="Name">Name</label></td>
                    <td><input class="form_input_box" type="text" id ="frame" name="Name" placeholder="<%=(name != null ? name : pay.getName())%>" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                <center>
                    <p>${CCMsg}</p>
                    <input class="button" type="submit" value="Add" required>
                </center>
                </td>
                </tr>
            </table>
               
    </body>
</html>

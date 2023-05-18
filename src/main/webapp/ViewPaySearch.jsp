<%-- 
    Document   : ViewPaySearch
    Created on : 18 May 2023, 2:13:53 pm
    Author     : issey
--%>
<%@ page import= "grp4.Model.Payment"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <%
        String CCNEr = (String) session.getAttribute("PayidSearch");
        String CCEEr = (String) session.getAttribute("dateSearch");
        Payment pay = (Payment) session.getAttribute("paymentN");
        
    %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payments search</title>
    </head>
    <body>
     <form action="searchpayServlet" method="post">
            <table>
                <tr>
                    <th>Search</th>
                    <th> 
                        <select name="searchOption">
                            <option value="PayidSearch">PaymentID</option>
                            <option value="dateSearch">Date(dd-mm-yyyy)</option>
                        </select>
                    </th>
                    <th><input type="text" name="searchBox" required></th>
                    <th><input type="submit" name="submitSearch"></th>
                </tr>
            </table>
        </form>
        <table class="order_list_table">
            <tr>
                <th>Credit Card Number</th>
                <th>Credit Card Expiry</th>
                <th>Credit Card CVC</th>
                <th>Name</th>
                <th>Amount</th>
               
            </tr>
            <tr>
                <td><%=pay.getCreditCardNumber()%></td>
                <td><%=pay.getCreditCardExpiry()%></td>
                <td><%=pay.getCreditCardCVC()%></td>
                <td><%=pay.getName()%></td>
                <td><%=pay.getAmount()%></td>
            </tr>
        
        </table>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if(errorMessage != null) { %>
            <h3 style="color: red"><%=errorMessage%></h3>
            <% } %>
    </body>
</html>

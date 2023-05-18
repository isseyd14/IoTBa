<%-- 
    Document   : ViewPayList
    Created on : 18 May 2023, 2:13:36 pm
    Author     : issey
--%>
  <%
 
        Payment pay = (Payment) session.getAttribute("Oldpayment");
        
    %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Payment Details</title>
    </head>
    <body>
         <form action="Payhistservlet" method="post">
               <tr>
                <th>Credit Card Number</th>
                <th>Credit Card Expiry</th>
                <th>Credit Card CVC</th>
                <th>Name</th>
               
            </tr>
            <tr>
                <td><%=pay.getCreditCardNumber()%></td>
                <td><%=pay.getCreditCardExpiry()%></td>
                <td><%=pay.getCreditCardCVC()%></td>
                <td><%=pay.getName()%></td>
            </tr>
        </form>
        <% if(errorMessage1 != null) { %>
            <h3 style="color: red"><%=errorMessage1%></h3>

<% } %>
        <h1>Hello World!</h1>
    </body>
</html>

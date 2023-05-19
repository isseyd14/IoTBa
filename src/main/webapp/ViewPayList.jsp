<%-- 
    Document   : ViewPayList
    Created on : 18 May 2023, 2:13:36 pm
    Author     : issey
--%>
<%@ page import="grp4.iotbay.Model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Payment Details</title>
    </head>
    <h2><a href="home.jsp">Back</a></h2>
        <h1>Current Payment Details</h1>
        <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        %>
        
        <%
        session.setAttribute("referringFile1", "ViewPayList.jsp");
        List<Pay> pays = (LinkedList<Pay>) session.getAttribute("pay");
        String currentEmail = (String) session.getAttribute("email");
        String errorMessage2 = (String) session.getAttribute("errorMessage2");
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
        
            <table>
            <% if(rs.next()) { %>
               <tr>
                <th>Credit Card Number</th>
                <th>Credit Card Expiry</th>
                <th>Credit Card CVC</th>
                <th>Name</th>
            </tr>
            <tr>
                <td><%= rs.getString("CardNumber") %></td>
                <td><%= rs.getString("Expdate") %></td>
                <td><%= rs.getString("CVC") %></td>
                <td><%= rs.getString("Name") %></td>
            </tr>
            <% } else{%>
            No payment information was found
            <%}%>
            
             <% if(pays == null) { %>
            <% try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "SELECT * FROM u236601339_iotBay.Payment WHERE Email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            rs = ps.executeQuery();

            }
                catch(SQLException e) {
        }
          

        %>
       <%}%>
 
<% if(errorMessage2 != null) { %>
    <p style="color: red"><%=errorMessage2%></p> <% } %>
    <form action="/FilterPayServlet" method="get">
        <label>Search by Pay ID: </label>
        <input type="text" name="payID">
        <label>Search by Date: </label>
        <input type="text" name="Paydate">
        <input type="submit" value="Filter">
    </form>
    <% if(pays == null) { %>

    <table class="stock-table">
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Amount</th>

        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("PayID") %></td>
            <td><%= rs.getString("Date")%></td>
            <td><%= rs.getString("Amount")%></td>

        </tr>
        <% }
            if(con != null) {
                con.close();
            }%>
    </table> <% } else { %>

    <table class="stock-table">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Stock Quantity</th>
            <th>Unit Price</th>
        </tr>
        <%for(Pay product : pays) { %>
        <td><%=product.getID() %></td>
        <td><%=product.getCreated()%></td>
        <td><%=product.getAmount()%></td>
        </tr>
        <% }
        }%>
    </table>
    </body>
</html>

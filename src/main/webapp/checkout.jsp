<%-- 
    Document   : checkout
    Created on : 19 May 2023, 9:27:28 pm
    Author     : Rhys
--%>

<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
Connection con ;
PreparedStatement pst ;
ResultSet rs ;
String query ;
con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
    .stock-table {
        border-collapse: collapse;
    }

    .stock-table td, .stock-table th {
        border: 1px solid black;
        padding: 0.5rem;
    }
</style>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
    </head>
    <body>
        <h1>IoT Bay Webstore</h1>
        <h2>My Items</h2>

        <%if(cart_list != null){%>
        
        <div>
            <table class="stock-table">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th></th>
        </tr>
        <% for(Cart product : cart_list) { 
        int id = (int)product.getId();
        query = "SELECT * FROM product WHERE productId=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, id);
        rs = pst.executeQuery();
        
        while(rs.next()){%>
        <tr>
            
        <td><%=rs.getString("productName") %></td>
        <td><%= rs.getString("productType")%></td>
            <td><%= rs.getString("productDescription")%></td>
            <td>1</td>
            <td>$<%= rs.getDouble("productPrice") %></td>
        <td><a href="remove-cart?id=<%=id %>">Remove</a></td>
        </tr>
        <%}}%>
    </table>
    <%  double sum = 0;
        for(Cart product : cart_list) { 
        int id = (int)product.getId();
        query = "SELECT productPrice FROM product WHERE productId=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, id);
        rs = pst.executeQuery();
        
        while(rs.next()){
        sum+=rs.getDouble("productPrice");
        }}
        
        session.setAttribute("Amount", sum);

    %>
        
    <h3>Total Price: $<%= sum %></h3>
    
    <a href="cart-checkout">Order</a>

    
        </div>
    <%}else{%>
    <div>NO ITEMS TO CHECKOUT</div>
    <%}%>
    </body>
</html>

</html>

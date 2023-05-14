<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Product" %><%--
  Created by IntelliJ IDEA.
  User: byronlester
  Date: 12/5/2023
  Time: 11:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Staff - Update</title>
</head>

<style>
  .stock-table {
    border-collapse: collapse;
  }

  .stock-table td, .stock-table th {
    border: 1px solid black;
    padding: 0.5rem;
  }
</style>

<body>
<%
  Product product = (Product) session.getAttribute("product");
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product");
%>

<h2>Select product to edit:</h2>
<form method="get" action="/FilterServlet">
  <label>Filter product table</label>
  <input type="text" name="productName" placeholder="Enter product name">
  <input type="submit" value="Search">
</form>

<% if(product == null) { %>
<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
    <th>Stock Quantity</th>
    <th>Unit Price</th>
  </tr>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getString("productName") %></td>
    <td><%= rs.getString("productType")%></td>
    <td><%= rs.getString("productDescription")%></td>
    <td><%= rs.getInt("productQuantity") %></td>
    <td><%= rs.getDouble("productPrice") %></td>
  </tr>
  <% } %>
</table>  <% } else { %>
<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
    <th>Stock Quantity</th>
    <th>Unit Price</th>
  </tr>
  <tr>
    <td><%=product.getName() %></td>
    <td><%=product.getType()%></td>
    <td><%=product.getDescription()%></td>
    <td><%=product.getQuantity()%></td>
    <td><%=product.getPrice()%></td>
  </tr>
  <% } %>
</table>

<form method="post" action="FindProductServlet">
  <strong><label>Type in product you wish to edit:</label></strong>
  <input type="text" name="productName"><br><br>
  <input type="submit" value="Select"/>

</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<% if(errorMessage != null) { %>

<h3 style="color: red"><%=errorMessage%></h3>

<% } %>

<%

  } catch (SQLException e) {
    e.printStackTrace();
  }
%>


<h2><a href="staff-home.jsp">Back</a></h2>

</body>
</html>

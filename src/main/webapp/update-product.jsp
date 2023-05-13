<%@ page import="java.sql.*" %><%--
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
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product");
%>


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
</table>

<form method="post" action="FindProductServlet">
  <label>Type in product you wish to edit:</label>
  <input type="text" name="productName"><br><br>
  <input type="submit" value="Select"/>

</form>

<%

  } catch (SQLException e) {
    e.printStackTrace();
  }
%>


<h2><a href="staff-home.jsp">Back</a></h2>

</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %><%--
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
<% session.setAttribute("referringFile", "update-product.jsp");
  List<Product> products = (LinkedList<Product>) session.getAttribute("products");%>

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
    ResultSet rs = stmt.executeQuery("SELECT * FROM product order by productName ASC");
%>

<h2>Select product to edit:</h2>
<form action="/FilterServlet" method="get">
  <label>Search by product name: </label>
  <input type="text" name="productName">
  <label>Search by product type: </label>
  <input type="text" name="productType">
  <input type="submit" value="Filter">
</form>
<form action="/ResetFilterServlet" method="get">
  <input type="submit" value="Reset">
</form>

<% if(products == null) { %>
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
    <td><form action="/FindProductServlet" method="post">
      <input type="hidden" value="<%=rs.getString("productName")%>" name = "productName">
      <input type="submit" value="Select">
    </form></td>
  </tr>
  <% } %>
</table>  <% con.close(); rs.close(); } else { %>
<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
    <th>Stock Quantity</th>
    <th>Unit Price</th>
  </tr>
  <tr>
    <%for(Product product : products) { %>
    <td><%=product.getName() %></td>
    <td><%=product.getType()%></td>
    <td><%=product.getDescription()%></td>
    <td><%=product.getQuantity()%></td>
    <td><%=product.getPrice()%></td>
  </tr>
    <% }
    }%>
</table>

<form method="post" action="FindProductServlet">
  <strong><label>Select product above OR type in product you wish to edit:</label></strong>
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

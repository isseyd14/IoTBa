<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Add product</title>
</head>
<body>

<style>
  .stock-table {
    border-collapse: collapse;
  }

  .stock-table td, .stock-table th {
    border: 1px solid black;
    padding: 0.5rem;
  }
</style>

<h2><a href="staff-home.jsp">Back</a></h2>


<form method="post" action="StockServlet" name="addProduct">
  <label>Product name:</label>
  <input type="text" name="product"><br><br>

  <label>Stock amount:</label>
  <input type="text" name="stock"><br><br>

  <label>Unit Price:</label>
  <input type="text" name="price"><br><br>

  <input type="submit" value="Add product">
</form>

<h1>Product List</h1>

<%
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product");
%>


<table class="stock-table">
  <tr>
    <th>Product Name</th>
    <th>Stock Amount</th>
    <th>Unit Price</th>
  </tr>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getString("productName") %></td>
    <td><%= rs.getInt("productQuantity") %></td>
    <td><%= rs.getDouble("productPrice") %></td>
  </tr>
  <% } %>
</table>


<%

  } catch (SQLException e) {
    e.printStackTrace();
  }
%>

</body>
</html>

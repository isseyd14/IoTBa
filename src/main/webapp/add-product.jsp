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

<form method="post" action="StockServlet" name="addProduct" >
  <label>Product name:</label>
  <input type="text" name="product"><br><br>

  <label>Stock amount:</label>
  <input type="text" name="stock"><br><br>

  <label>Unit Price:</label>
  <input type="text" name="price"><br><br>

  <input type="submit" value="Add product">
</form>

<%
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product");

    while (rs.next()) {
      String productName = rs.getString("productName");
      int stockAmount = rs.getInt("productQuantity");
      double unitPrice = rs.getDouble("productPrice");

%>
<table class="stock-table">
  <tr>
    <th>Product Name</th>
    <th>Stock Amount</th>
    <th>Unit Price</th>
  </tr>
  <tr>
    <td><%= productName %></td>
    <td><%= stockAmount %></td>
    <td><%= unitPrice %></td>
  </tr>
</table>

<%
    }
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>

</body>
</html>

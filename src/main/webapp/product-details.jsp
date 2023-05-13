<%@ page import="grp4.iotbay.Product" %>
<%@ page import="java.sql.*" %><
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <% Product product = (Product) session.getAttribute("product"); %>
  <% String productName = product.getName(); %>
    <title>Modify Product - <%=productName%></title>
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

  String query = "SELECT productName, productType, productDescription FROM product WHERE productName = ?";

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    PreparedStatement stmt = con.prepareStatement(query);

    stmt.setString(1, productName);

    ResultSet rs = stmt.executeQuery();
%>


<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getString("productName") %></td>
    <td><%= rs.getString("productType")%></td>
    <td><%= rs.getString("productDescription")%></td>
  </tr>
  <% }
  }
  catch(SQLException e) {
      e.printStackTrace();
    }%>
</table>

<form method="post" action="UpdateProductServlet"></form>
<label>Update Name: </label>
<input type="text" name="name"><br><br>
<label>Update Type: </label>
<input type="text" name="type">
<label>Update Description: </label>
<input type="text" name="description">
<input type="submit" value="Update">

</body>
</html>

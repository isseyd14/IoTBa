<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Remove Product</title>
</head>
<%String errorMessage = (String) request.getAttribute("errorMessage"); %>
<%String successMessage = (String) request.getAttribute("successMessage"); %>

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
<h2><a href="staff-home.jsp">Back</a></h2>
<h1>Product List</h1>
<%
  Connection con;

  try {
    con = DriverManager.getConnection(
            "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
            "u236601339_iotbayAdmin", "iotBaypassword1"
    );
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
    <td><%= rs.getString("productName") %>
    </td>
    <td><%= rs.getInt("productQuantity") %>
    </td>
    <td>$<%= rs.getDouble("productPrice") %>
    </td>
    <td>
      <form action="RemoveServlet" method="post">
        <input type="hidden" name="productName" value="<%=rs.getString("productName")%>">
        <input type="submit" value="Remove product">
      </form>
    </td>
  </tr>
  <% } con.close(); rs.close(); %>
</table>

<form action="RemoveServlet" method="post" name="removeProduct">
  <label>Use remove buttons above OR enter name of product to be removed from listing:</label>
  <input type="text" name="productName"/>


  <input type="submit" value="Remove product">
</form>

<% if(errorMessage != null) { %>
<p style="color: red"><%=errorMessage%></p>

<% } %>

<% if(successMessage != null) { %>
<p style="color: green"><%=successMessage%></p>
<% } %>

</body>
</html>

<% } finally {

} %>
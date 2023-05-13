<%@ page import="grp4.iotbay.Product" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <% Product product = (Product) session.getAttribute("product"); %>
  <% String productName = product.getName(); %>
    <title>Modify Product - <%=product.getName()%></title>
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

<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><%=product.getName()%></td>
    <td><%=product.getType()%></td>
    <td><%=product.getDescription()%></td>
  </tr>
</table>

<form method="post" action="update-product.jsp">
<label>Update Name: </label>
<input type="text" name="name"><br><br>
<label>Update Type: </label>
<input type="text" name="type">
<label>Update Description: </label>
<input type="text" name="description">
<input type="submit" value="Update">
</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<%if(errorMessage != null) { %>
<p><%=errorMessage%></p>

<% } %>

</body>
</html>

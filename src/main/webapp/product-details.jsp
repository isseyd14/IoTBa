<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <% Product product = (Product) session.getAttribute("product"); %>
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

<h1>Updating: <%=product.getName()%></h1>

<table class="stock-table">
  <tr>
    <th>Name</th>
    <th>Type</th>
    <th>Description</th>
    <th>Stock Quantity</th>
    <th>Unit Price</th>
  </tr>
  <tr>
    <td><%=product.getName()%></td>
    <td><%=product.getType()%></td>
    <td><%=product.getDescription()%></td>
    <td><%=product.getQuantity()%></td>
    <td><%=product.getPrice()%></td>
  </tr>
</table>

<form method="post" action="UpdateProductServlet">
<input type="hidden" name="originalName" value="<%= product.getName() %>">
<input type="hidden" name="originalType" value="<%= product.getType()%>">
<input type="hidden" name="originalDesc" value="<%= product.getDescription() %>">
<input type="hidden" name="originalQuantity" value="<%= product.getQuantity() %>">
<input type="hidden" name="originalPrice" value="<%= product.getPrice()%>">
<label>Update Name: </label>
<input type="text" name="name"><br><br>
  <label>Update Type: </label>
<input type="text" name="type">
<label>Update Description: </label>
<input type="text" name="description">
  <label>Update Quantity: </label>
  <input type="text" name="quantity">
  <label>Update Price: </label>
  <input type="text" name="price">
<input type="submit" value="Update">
</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% String successMessage = (String) request.getAttribute("successMessage"); %>

<% if(errorMessage != null) { %>
<h3 style="color: red"><%=errorMessage%></h3>

<% } %>

<% if(successMessage != null) { %>
<h3 style="color: green"><%=successMessage%></h3>

<% } %>

<form action="update-product.jsp">
  <input type="submit" value="back">
</form>
<form action="ReturnHomeServlet" method="get">
  <input type="submit" value="Return Home">
</form>

<!-- <h2><a href="update-product.jsp">Back</a> </h2> -->
<!-- <h2><a href="ReturnHomeServlet" >Return home</a></h2> -->

</body>
</html>

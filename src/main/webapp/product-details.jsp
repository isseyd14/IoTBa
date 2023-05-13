<%@ page import="grp4.iotbay.Product" %>
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
  </tr>
  <tr>
    <td><%=product.getName()%></td>
    <td><%=product.getType()%></td>
    <td><%=product.getDescription()%></td>
  </tr>
</table>

<form method="post" action="UpdateProductServlet">
<input type="hidden" name="originalName" value="<%= product.getName() %>">
<input type="hidden" name="originalType" value="<%= product.getType()%>">
<input type="hidden" name="originalDesc" value="<%= product.getDescription() %>">
<label>Update Name: </label>
<input type="text" name="name"><br><br>
<label>Update Type: </label>
<input type="text" name="type">
<label>Update Description: </label>
<input type="text" name="description">
<input type="submit" value="Update">
</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% String successMessage = (String) request.getAttribute("successMessage"); %>

<% if(errorMessage != null) { %>
<p style="color: red"><%=errorMessage%></p>

<% } %>

<% if(successMessage != null) { %>
<p style="color: green"><%=successMessage%></p>

<% } %>

<h2><a href="update-product.jsp">Back</a> </h2>
<h2><a href="staff-home.jsp">Return home</a></h2>

</body>
</html>

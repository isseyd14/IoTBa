<%@ page import="grp4.iotbay.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<html>
<head>
    <title>Staff Home</title>

</head>

<%
    // Product product = (Product) session.getAttribute("product");
    List<Product> products = (LinkedList<Product>) session.getAttribute("products");
    String Name = (String) session.getAttribute("name");
    String errorMessage = (String) request.getAttribute("errorMessage");
    session.setAttribute("referringFile", "staff-home.jsp");


%>
<body>
<img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
<h1>Welcome to IoT Stock Management staff member: <%=Name%> </h1>
<h2><a href="add-product.jsp">Add Product</a></h2>
<h2><a href="update-product.jsp">Update Product Details</a></h2>
<h2><a href="remove-product.jsp">Remove Product</a></h2>
<h2><a href="LogoutServlet">Logout</a></h2>

<h2>Stocked products</h2>

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
<% if(errorMessage != null) { %>
<p style="color: red"><%=errorMessage%></p> <% } %>
<%  Connection con = null;
    ResultSet rs = null; %>

<% if(products == null) {
    try {
        con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
        );

        con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
        Statement stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM product order by productName ASC");



    }
    catch(SQLException e) {

    }
}

    %>

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
    </tr>
    <% }
    if(con != null) {
        con.close();
    }%>
</table> <% } else { %>

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

} %>
</table>

</body>
</html>

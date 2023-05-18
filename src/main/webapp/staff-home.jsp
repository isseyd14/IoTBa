<%@ page import="grp4.iotbay.Model.Product" %>
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

<style>

    body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
    }

    .standard-Nav {
        display: flex;
        height: 70px;
        background-color: #f3f3f3;
        box-shadow: 0px -10px 36px 3px rgba(143, 142, 142, 0.537);

    }

    .nav-logo {
        font-size: 24px;
        font-weight: bold;
        text-decoration: none;
        color: #333;
        margin-top: auto;
        margin-bottom: auto;

        padding-left: 50px;
        padding-right: 50px;
    }

    .nav-links {
        display: flex;
        flex-grow: 1;
        justify-content: flex-end;
        list-style: none;
        margin: 0;
        padding: 0;
        flex-basis: 0;
    }

    .nav-links .nav-search {

        width: 100%;
        margin-left: 20px;
        margin-right: 20px;
        margin-top: auto;
        margin-bottom: auto;
    }


    .nav-links .nav-button a  {
        display: flex;
        height: 100%;
        padding-left: 40px;
        padding-right: 40px;
        align-items: center;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        color: #fff;
        background-color: #034473;
        transition: background-color 0.3s ease;

    }

    .name-card {
        display: flex;
        height: 100%;
        padding-left: 40px;
        padding-right: 40px;
        align-items: center;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        color: black;
        background-color: #f3f3f3;
        transition: background-color 0.3s ease;
    }

    .nav-links .nav-button a:hover {
        background-color: #0c78c5;
    }

    .nav-links .nav-button .active {
        background-color: #4494d5;
    }

    .h2Button a {
        display: flex;
        height: 100%;
        padding-left: 40px;
        padding-right: 40px;
        align-items: center;
        font-size: 16px;
        font-weight: bold;
        text-decoration: none;
        color: #fff;
        background-color: #4CAF50;
        transition: background-color 0.3s ease;
    }

    .h2Button a:hover {
        background-color: #80d27b;
    }

    .form-container {

    }

    /*.form-container label {
        margin-bottom: 5px;
    }

    .form-container input[type="text"],
    .form-container input[type="submit"] {
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    .form-container input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .form-container input[type="submit"]:hover {
        background-color: #45a049;
    } */

    table {
        border-collapse: collapse;
        width: 100%;
    }

    .stock-table {
        border-collapse: collapse;
    }

    .stock-table td, .stock-table th {
        border: 1px solid black;
        padding: 0.5rem;
    }
</style>

<%
    // Product product = (Product) session.getAttribute("product");
    List<Product> products = (LinkedList<Product>) session.getAttribute("products");
    String name = (String) session.getAttribute("name");
    String errorMessage = (String) request.getAttribute("errorMessage");
    session.setAttribute("referringFile", "staff-home.jsp");


%>
<body>

<nav class="standard-Nav">
    <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    <ul class="nav-links">
        <li class="name-card">Welcome, <%=name%></li>
        <li class="h2Button"><a href="add-product.jsp">Add Product</a></li>
        <li class="h2Button"> <a href="update-product.jsp"> Update Product Details</a></li>
        <li class="h2Button"><a href="remove-product.jsp">Remove Product</a></li>


        <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
    </ul>

</nav>



<h2>Stocked products</h2>

<div class="form-container">

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
</div>

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
        <td>$<%= rs.getDouble("productPrice") %></td>
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
    <td>$<%=product.getPrice()%></td>
</tr>
<% }

} %>
</table>

</body>
</html>

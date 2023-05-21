
<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="javax.swing.plaf.nimbus.State" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<html>
<head>
    <title>Staff Home</title>
    <link rel="stylesheet" href="topbar.css">
</head>

<style>

    
.searchForm {
        display: flex;

        width: 100%;
        justify-content: center;
        

    }

    .seachForm input[type=submit] {

        border: none;
        height: 100%;
        padding: 10px;
        padding-left: 10px;
        padding-right: 10px;
        align-items: center;
        font-size: 14px;
        font-weight: bold;
        text-decoration: none;
        color: white;



    }

    .searchField {
        width: calc(100% - 170px);
        padding-left: 20px;
        padding-right: 20px;
        height: 30px;
        font-size: 14px;
        max-width: 500px;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        box-shadow: 0 4px 15px 0 rgba(0, 0, 0, 0.157);
    }

    .product-card {
        display: flex;
        align-items: center;
        padding: 10px;
        border: 2px #b3b3b3 solid;
        border-radius: 5px;
        margin-left: 30px;
        margin-right: 30px;
        margin-bottom: 20px;
    }



.mainBody{
    margin:50px;
    
}

.formBody{
margin-left:auto;
margin-right:auto;
background-color: #ffffff8f;
       padding:50px;
       border-radius: 40px;
       max-width: 1100px;
       min-width: 800px;
       box-shadow: 0 4px 15px 0 rgba(0, 0, 0, 0.157);
      
    
}

.searchForm {
  display: flex;
  justify-content: center;


       
}

.searchForm label {
  font-weight: bold;
  margin-bottom: 50px;

}

.searchForm input[type="text"] {
  padding: 10px;
  border: none;
  border-radius: 30px;
  background-color: #f5f5f5;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  margin-bottom: 10px;
  width: 300px;
  font-size: 14px;
  margin-top:20px;
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
        <li class="nav-button" style="min-width: 400px;"><a style="background-color: #ff000000; color:black;">Welcome, <%=name%> </a></li>
        <li class="nav-button"><a href="add-product.jsp">Add Product</a></li>
        <li class="nav-button"> <a href="update-product.jsp"> Update Product Details</a></li>
        <li class="nav-button"><a href="remove-product.jsp">Remove Product</a></li>


        <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
    </ul>

</nav>

<div class="mainBody">

<h2>Stocked products</h2>

<div class="formBody">

<form action="FilterServlet" method="get" class="searchForm">
    <div>
    <label>Search by product name: </label>
    <input type="text" name="productName" class="inputField" placeholder="product name">
    </div>
    <div>
    <label>Search by product type: </label>
    <input type="text" name="productType" class="inputField" placeholder="product type">
</div>
    <input type="submit" value="Filter" class="button">
</form>
<form action="ResetFilterServlet" method="get">
    <input type="submit" value="Reset" class="button">
</form>
</div>

<% if(errorMessage != null) { %>
<p style="color: red"><%=errorMessage%></p> <% } %>

<%  Connection con = null;
    ResultSet rs = null;
    Statement stmt = null;%>

<% if(products == null) {
    try {
        con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
        );

        con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM product order by productName ASC"); %>

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
        <% } %>
    </table>
 <% } finally {
        try {
            if(rs != null) {
                rs.close();
            }
            if(stmt != null) {
                stmt.close();
            }
            if(con != null) {
                con.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
} else { %>

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

</div>
</body>
</html>

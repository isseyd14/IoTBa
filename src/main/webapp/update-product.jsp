
<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: byronlester
  Date: 12/5/2023
  Time: 11:53 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Staff - Update</title>
    <link rel="stylesheet" href="topbar.css">
</head>
<% session.setAttribute("referringFile", "update-product.jsp");
  List<Product> products = (LinkedList<Product>) session.getAttribute("products");%>

    <style>
      body {
          background-color: #034473;
      }
    
      .mainContent {
          background-color: #034473;
      }
    
      .standard-Nav {
          display: flex;
          height: 70px;
          background-color: #f3f3f3;
          box-shadow: 0px -10px 36px 3px rgba(143, 142, 142, 0);
    
      }
    
      .submitsection {
          position: fixed;
          width: 100vw;
          bottom: 0;
          height: 100px;
          background-color: #f4f4f4;
    
    
          box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
    
    
          padding-top: 40px;
          padding-right: 40px;
    
          display: flex;
    
          display: none;
      }
    
      .submitDiv {
          margin-left: auto;
          display: flex;
          flex-direction: row;
          align-items: center;
          margin-right: 100px;
    
    
      }
    
    
      .form-table {
    
          display: flex;
          justify-content: center;
          margin-left: auto;
          margin-right: auto;
    
          height: 500px;
      }
    
    
      .form-table label {
          display: block;
          margin-bottom: 5px;
      }
    
      .form-table input {
          display: block;
          width: 100%;
          padding: 5px;
          border: none;
          border-radius: 4px;
      }
    
      .innerBody {
          margin-top: 40px;
          margin-left: auto;
          margin-right: auto;
          max-width: 800px;
          min-height: 100%;
          background-color: #f3f3f3;
          padding: 50px;
      }
    
      .nav-links .nav-button a {
          color: #034473;
          background-color: #509e6000;
          border-right: 2px solid #034473;
    
    
      }
    
      .nav-links .nav-button a:hover {
          background-color: #0c78c578;
      }
    
      .tableContainer {
          width: 100%;
          overflow-x: auto;
      }
    
    
      .stock-table th,
      .stock-table td {
          font-size: 10px;
      }
    
    
    
      .stock-table .table-actions .quantity {
          font-size: 10px;
          color: #888888;
      }
    
      .button {
          margin: 40px;
      }
    
      form {
          display: flex;
          align-items: center;
    
          flex-direction: column;
      }
    
      .nav-logo {
          margin-left: auto;
          margin-right: auto;
      }
    
      .mainContent {
          margin-top: 40px;
      }
    
      .inputField{
        background-color: white;
      }
    </style>

<body>

  <nav class="standard-Nav">
    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60"
        alt="Product Image">

</nav>
<%
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product order by productName ASC");
%>

<div class="mainContent">

  <h2><a href="staff-home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Home</a></h2>
  <div class="innerBody">


<h2>Select product to edit:</h2>
<form action="FilterServlet" method="get">
  <label>Search by product name: </label>
  <input type="text" name="productName" class="inputField">
  <label>Search by product type: </label>
  <input type="text" name="productType" class="inputField">
  <input type="submit" value="Filter" class="button">
</form>
<form action="ResetFilterServlet" method="get">
  <input type="submit" value="Reset" class="button" style="border:2px solid #034473; color:#034473; background-color: #d9d9d900;">
</form>

<% if(products == null) { %>
  <div class="tableContainer">
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
    <td><form action="FindProductServlet" method="post">
      <input type="hidden"  value="<%=rs.getString("productName")%>" name = "productName">
      <input type="submit" value="Select" class="button"  style="font-size: 12px;  padding:10px;">
    </form></td>
  </tr>
  <% } %>
</table>  </div><% con.close(); rs.close(); } else { %>

  <div class="tableContainer">
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
    }%>
</table>
  </div>
<form method="post" action="FindProductServlet">
  <strong style="margin:40px;"><label >Select product above OR type in product you wish to edit:</label></strong>
  <input type="text" class="inputField" name="productName"><br><br>
  <input type="submit" value="Select" class="button"/>

</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>

<% if(errorMessage != null) { %>

<h3 style="color: red"><%=errorMessage%></h3>

<% } %>

<%

  } catch (SQLException e) {
    e.printStackTrace();
  }
%>




</body>
</html>

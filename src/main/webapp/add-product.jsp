
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Add product</title>
    <link rel="stylesheet" href="topbar.css">
</head>
<body>

<style>


body{
  background-color: #034473;
}
 

.mainContent{
  background-color: #034473;
}

.standard-Nav {
    display: flex;
    height: 70px;
    background-color: #f3f3f3;
    box-shadow: 0px -10px 36px 3px rgba(143, 142, 142, 0);
    
}

  .submitsection{
    position:fixed;
    width:100vw;
    bottom:0;
    height:100px;
    background-color: #f4f4f4;


    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);


    padding-top:40px;
    padding-right:40px;
    
    display:flex;

    display:none;
  }

  .submitDiv{
    margin-left:auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-right:100px;
    

  }
  

.form-table{

  display: flex;
  justify-content: center;
  margin-left:auto;
  margin-right:auto;

  height:500px;
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

.innerBody{
margin-top:40px;
  margin-left:auto;
  margin-right:auto;
max-width:800px;
min-height:100%;
  background-color: #f3f3f3;
  padding:50px;
}

.nav-links .nav-button a {
  color:#034473; 
background-color:#509e6000; 
 border-right: 2px solid #034473; 


}

.nav-links .nav-button a:hover {
    background-color: #0c78c578;
}

.tableContainer{
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
      .button{
       margin:40px;
      }
   
      form{
        display: flex;
       align-items: center;

        flex-direction: column;
      }
      .nav-logo{
        margin-left:auto;
        margin-right:auto;
      }
      .mainContent{
        margin-top:40px;
      }
</style>

<nav class="standard-Nav">
  <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
  
</nav>

<div class="mainContent">

<h2><a href="staff-home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Back</a></h2>

<div class="innerBody">

  <h1>Add Product</h1>
 
<form method="post" action="AddProductServlet" name="addProduct">
  <label>Name:</label>
  <input type="text" name="productName" class="inputField" placeholder="product name"><br><br>

  <Label>Type</Label>
  <input type="text" name="productType" class="inputField" placeholder="type of product"><br><br>

  <Label>Description</Label>
  <input type="text" name="productDescription" class="inputField" placeholder="description"><br><br>

  <label>Stock amount:</label>
  <input type="text" name="productStock" class="inputField" placeholder="stock count"><br><br>

  <label>Unit Price:</label>
  <input type="text" name="productPrice" class="inputField" placeholder="unit price"><br><br>

  <input type="submit" value="Add product" class="button">

  <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
  %>
  <p style="color: red;"><%=errorMessage %></p>
  <%
    }
  %>
  <% String successMessage = (String) request.getAttribute("successMessage");
  if(successMessage != null) { %>
  <p style="color: green"><%=successMessage%></p>
  <% } %>
</form>

<h1>Product List</h1>

<%
  Connection con;

  try {
    con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM product ORDER BY productName ASC");
%>

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
  </tr>
  <% } %>
</table>

</div>


<%

  } catch (SQLException e) {
    e.printStackTrace();
  }
%>
</div>
</div>
</body>
</html>

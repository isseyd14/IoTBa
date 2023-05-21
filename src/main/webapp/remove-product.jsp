
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Remove Product</title>
    <link rel="stylesheet" href="topbar.css">
</head>
<%String errorMessage = (String) request.getAttribute("errorMessage"); %>
<%String successMessage = (String) request.getAttribute("successMessage"); %>

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
      font-size: 16px;
  }



  .stock-table .table-actions .quantity {
      font-size: 10px;
      color: #888888;
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
  <div class="mainContent">



    <h2><a href="staff-home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Home</a></h2>

<div class="innerBody">
  <form action="RemoveServlet" method="post" name="removeProduct">
    <label style="">Use remove buttons below OR enter name of product to be removed from listing:</label>
    <input type="text" name="productName" class="inputField" placeholder="enter product name"/>


    <input type="submit" value="Remove product" class="button" style="font-size: 12px;">
  </form>
  <% if(errorMessage != null) { %>
  <p style="color: red"><%=errorMessage%></p>

  <% } %>

  <% if(successMessage != null) { %>
  <p style="color: green"><%=successMessage%></p>
  <% } %>
<%
  Connection con = null;
  Statement stmt = null;
  ResultSet rs = null;

  try {
    con = DriverManager.getConnection(
            "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
            "u236601339_iotbayAdmin", "iotBaypassword1"
    );
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM product");
%>

  <h1>Product List</h1>
  <table class="stock-table">
    <tr>
      <th>Product Name</th>
      <th>Stock Amount</th>
      <th>Unit Price</th>
      <th></th>
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
          <input type="submit" value="Remove product" class="button" style="font-size: 12px;  padding:10px;">
        </form>
      </td>
    </tr>
    <% } %>
  </table>
  <% } finally {
    try {
      if(rs != null) {
        stmt.close();
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
  } %>
</div>
</div>
</body>
</html>


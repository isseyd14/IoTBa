
<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <% Product product = (Product) session.getAttribute("product"); %>
    <title>Modify Product - <%=product.getName()%></title>
    <link rel="stylesheet" href="topbar.css">
</head>

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


<div class="mainContent">

  <h2><a href="staff-home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Home</a></h2>
  <div class="innerBody">

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
    <td>$<%=product.getPrice()%></td>
  </tr>
</table>

<form method="post" action="UpdateProductServlet" style="margin-top:50px;">
<input type="hidden" name="originalName" value="<%= product.getName() %>">
<input type="hidden" name="originalType" value="<%= product.getType()%>">
<input type="hidden" name="originalDesc" value="<%= product.getDescription() %>">
<input type="hidden" name="originalQuantity" value="<%= product.getQuantity() %>">
<input type="hidden" name="originalPrice" value="<%= product.getPrice()%>">
<label>Update Name: </label>
<input type="text" name="name" class="inputField" placeholder="New Name">
  <label>Update Type: </label>
<input type="text" name="type" class="inputField" placeholder="New type">
<label>Update Description: </label>
<input type="text" name="description" class="inputField" placeholder="New description">
  <label>Update Quantity: </label>
  <input type="text" name="quantity" class="inputField" placeholder="New quantity">
  <label>Update Price: </label>
  <input type="text" name="price" class="inputField" placeholder="New price">


  <div class="submitsection">
                                  
    <div class="submitDiv">
<input type="submit" value="Update" class="button">
</form>

<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<% String successMessage = (String) request.getAttribute("successMessage"); %>

<% if(errorMessage != null) { %>
<h3 style="color: red"><%=errorMessage%></h3>

<% } %>

<% if(successMessage != null) { %>
<h3 style="color: green"><%=successMessage%></h3>

<% } %>

<form action="update-product.jsp" >
  <input type="submit" value="Back" class="button" style="border:2px solid #034473; color:#034473; background-color: #d9d9d900;">
</form>
<form action="ReturnHomeServlet" method="get">
  <input type="submit" value="Return Home" class="button" style="border:2px solid #034473; color:#034473; background-color: #d9d9d900;">
</form>

  </div>
  </div>

<!-- <h2><a href="update-product.jsp">Back</a> </h2> -->
<!-- <h2><a href="ReturnHomeServlet" >Return home</a></h2> -->
  </div>
  </div>
</body>
</html>
<script>
  const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
const submitSection = document.querySelector('.submitsection');

inputs.forEach((input) => {
  input.addEventListener('input', toggleSubmitSectionVisibility);
});

function toggleSubmitSectionVisibility() {
  let showSubmitSection = false;

  inputs.forEach((input) => {
    if (input.value.trim() !== '') {
      showSubmitSection = true;
    }
  });

  submitSection.style.display = showSubmitSection ? 'flex' : 'none';
}
</script>
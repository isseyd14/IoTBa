<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>

<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>IoTBay Search</title>
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
    .stock-table {
  width: 100%;
  border-collapse: collapse;
  border-radius: 20px;
  overflow: hidden;
}

.stock-table th,
.stock-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #e0e0e0;
}

.stock-table th {
    background-color: #f3f3f3af;
  font-weight: bold;
  text-transform: uppercase;
}

.stock-table tbody tr:hover {
  background-color: #f9f9f9;
}

.stock-table a {
  text-decoration: none;
  color: #fff;
  background-color: #034473;
  padding: 8px 16px;
  border-radius: 20px;
  transition: background-color 0.3s ease;
}

.stock-table a:hover {
    background-color: #4494d5;
}

.stock-table .table-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.stock-table .table-actions .quantity {
  font-size: 14px;
  color: #888888;
}

.stock-table .table-actions .add-to-cart {
  font-size: 16px;
  font-weight: bold;
}


.mainBody{
    margin:50px;
}

.formBody{
    background-color: #f3f3f357;
       padding:50px;
       border-radius: 40px;
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
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");

    // Product product = (Product) session.getAttribute("product");
    List<Product> products = (LinkedList<Product>) session.getAttribute("products");
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    String errorMessage = (String) request.getAttribute("errorMessage");
    session.setAttribute("referringFile", "home.jsp");

    if(email == null){
%>

<body class="loginFail">Error no Login</body>

<%} else if(email != null){

%>
<body>

    <nav class="standard-Nav">
        <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
        <ul class="nav-links">
    
            <li class="nav-button" style="min-width:400px; "><a href="account.jsp" style="background-color: #ff000000; color:black;">Welcome, <%out.print(name);%></a></li>
            <li class="nav-button"><a class="active" href="home.jsp">Search</a></li>
            <% if(cart_list != null){%>
            <li class="nav-button"><a  href="cart.jsp">
                    Cart(<%=cart_list.size()%>)
                </a></li>
            <%}else{%><li class="nav-button"><a  href="cart.jsp">
                    Cart
                </a></li>
       
            <%}%>
            <li class="nav-button"><a href="orders.jsp">Orders</a></li>
            <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
            <li class="nav-button"><a href="ViewPayList.jsp">Payment history</a></li>

        </ul>
    </nav>

    <div class="mainBody">

    <h1>Available products:</h1>

<<<<<<< Updated upstream

    <form action="FilterServlet" method="get">
        <label>Search by product name: </label>
        <input type="text" name="productName">
        <label>Search by product type: </label>
        <input type="text" name="productType">
        <input type="submit" value="Filter">
    </form>
    <form action="ResetFilterServlet" method="get">
        <input type="submit" value="Reset">
=======
    <div class="formBody">
    <form action="/FilterServlet" method="get" class="searchForm">
        <div> <label >Search by product name: </label>
            <input type="text" name="productName" placeholder="product name"></div>
       <div> <label>Search by product type: </label>
        <input type="text" name="productType" placeholder="product type"></div>
       
        <input type="submit"  value="Filter" class="button">
    </form>
    <form action="/ResetFilterServlet" method="get" class="searchForm" >
        <input type="submit" value="Reset" class="button">
>>>>>>> Stashed changes
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
            <th>Cart</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td style="max-width:150px;"><%= rs.getString("productName") %></td>
            <td style="max-width:150px;"><%= rs.getString("productType")%></td>
            <td style="max-width:450px;"><%= rs.getString("productDescription")%></td>
            <td style="max-width:100px;"><%= rs.getInt("productQuantity") %></td>
            <td style="max-width:100px;">$<%= rs.getDouble("productPrice") %></td>
            <td style="min-width:150px;"><a href="add-to-cart?id=<%=rs.getInt("productId")%>"> Add to Cart</a></td>
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
        <%for(Product product : products) { %>
        <td style="max-width:150px;"><%=product.getName() %></td>
        <td style="max-width:150px;"><%=product.getType()%></td>
        <td style="max-width:450px;"><%=product.getDescription()%></td>
        <td style="max-width:100px;"><%=product.getQuantity()%></td>
        <td style="max-width:100px;">$<%=product.getPrice()%></td>
        <td style="max-width:150px;"><%=product.getId()%></td>
        <!--<td><a class="btn btn-dark" href="add-to-cart?id=<%=product.getId()%>">Add to Cart</a> <a</td>-->
        </tr>
        <% }
        }%>
    </table>


</div>
</body>
<%}%>
</html>
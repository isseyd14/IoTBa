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
    
            <li class="nav-button" style="min-width:400px; "><a href="account.jsp" style="background-color: #ff000000; color:black;">Welcome, <%=name%></a></li>
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
        Statement stmt = null; %>

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
            </tr>  <% } %>
    </table>
        <% } finally {
            {
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
        }
        } else {%>

    <table class="stock-table">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Stock Quantity</th>
            <th>Unit Price</th>
        </tr>
        <%for(Product product : products) { %>
        <td><%=product.getName() %></td>
        <td><%=product.getType()%></td>
        <td><%=product.getDescription()%></td>
        <td><%=product.getQuantity()%></td>
        <td>$<%=product.getPrice()%></td>
        <td><a href="add-to-cart?id=<%=(int) Math.round(product.getId())%>">Add to Cart</a></td>
        </tr>
        <% } } }%>
    </table>


</div>
</body>
</html>
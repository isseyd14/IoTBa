<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>IoTBay Search</title>
</head>

<%
    // Product product = (Product) session.getAttribute("product");
    List<Product> products = (LinkedList<Product>) session.getAttribute("products");
    String name = (String) session.getAttribute("name");
    String errorMessage = (String) request.getAttribute("errorMessage");
    session.setAttribute("referringFile", "home.jsp");

%>

<!-- <style>
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


    .nav-links .nav-button a {
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

    .nav-links .nav-button a:hover {
        background-color: #0c78c5;
    }

    .nav-links .nav-button .active {
        background-color: #4494d5;
    }

    .searchForm {
        display: flex;
        height: 100%;
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
        background-color: #034473;


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

    .product-card img {
        width: 150px;
        height: 150px;
        margin-right: 20px;
    }

    .product-details h2 {
        font-size: 18px;
        margin: 0 0 10px;
    }

    .product-details p {
        font-size: 14px;
        margin: 0;
    }
</style> -->

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

    <nav class="standard-Nav">
        <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
        <ul class="nav-links">
            <li class="nav-search">

                <form name="searchQuery" action="searchQuery" method="POST" class="seachForm">
                    <input type="text" id="searchQuery" name="searchQuery" placeholder="Search IOTBay"
                        class="searchField">
                    <input type="submit" value="Search">
                </form>


            </li>
            <li class="nav-button">Welcome, <%=name%> </li>
            <li class="nav-button"><a class="active" href="home.jsp">Search</a></li>

            <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <h1>Available products:</h1>

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
        <%for(Product product : products) { %>
        <td><%=product.getName() %></td>
        <td><%=product.getType()%></td>
        <td><%=product.getDescription()%></td>
        <td><%=product.getQuantity()%></td>
        <td><%=product.getPrice()%></td>
        </tr>
        <% }
        }%>
    </table>



   <!-- Jack old Table

    <div class="main display">
        <h1 style="text-align: center; padding-top:50px;">Search Results...</h1>
        <p style="color:red;">This table is an example table. As this is hard coded, we will place the java code around
            this. The tr will be placed in a while loop as each
            %search% row is retrieved from the database. Data will be added acordingly</p>
        <table>
            <tbody>
                <tr>
                    <td>
                        <div class="product-card">
                            <img src="https://picsum.photos/id/1/100/100" alt="Product Image">
                            <div class="product-details">
                                <h2>Phone</h2>
                                <p>This is a random description to describe a product that would be in our search. THis
                                    is just random adipiscin rnnrogrnog4oir</p>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="product-card">
                            <img src="https://picsum.photos/id/2/100/100" alt="Product Image">
                            <div class="product-details">
                                <h2>Cool thing</h2>
                                <p>This is a random description to describe a product that would be in our search. THis
                                    is just random adipiscin rnnrogrnog4oir</p>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="product-card">
                            <img src="https://picsum.photos/id/3/100/100" alt="Product Image">
                            <div class="product-details">
                                <h2>Watch</h2>
                                <p>This is a random description to describe a product that would be in our search. THis
                                    is just random adipiscin rnnrogrnog4oir</p>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>


    </div> -->

</body>


</html>
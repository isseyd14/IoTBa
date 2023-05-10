<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
</style>
<%
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
    if(email == null){
%>

<body>Error no Login</body>

<%} else if(email != null){

%>
<head>
    <title><%out.print(name);%> - Your Account</title>
</head>
<body>
<nav class="standard-Nav">
    <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    <ul class="nav-links">
        <li class="nav-button"><a href="account.jsp">Welcome, <%out.print(name);%></a></li>
        <li class="nav-button"><a class="active" href="home.jsp">Search</a></li>

        <li class="nav-button"><a href="logout">Logout</a></li>
    </ul>
</nav>

<h3>This action will irreversibly delete your account from IoTBay and all of your saved information!</h3>
<h3>Are you sure you wish to proceed?</h3>

<form method="post" action="DeleteServlet" name="delete" >
    <label>Confirm Password:</label>
    <input type="password" name="password" required><br><br>
    <input type="submit" value="Yes, Proceed">
    <a type="button" href="account.jsp">No, Never mind</a>
</form>

</body>
<%}
%>
</html>
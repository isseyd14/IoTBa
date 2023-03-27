<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>IoTBay Search</title>
</head>
<body>
<div class="topnav">
    <a class="active" href="home.jsp">Home</a>
    <a href="logout">Logout</a>
</div>
<form name="searchQuery" action="searchQuery" method="POST">
    <label for="searchQuery">Search:</label>
    <input type="text" id="searchQuery" name="searchQuery">
    <input type="submit" value="Submit">
</form>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<html>
<head>
    <title>Staff Home</title>
</head>

<%
    String Name = (String) session.getAttribute("name");
%>
<body>
<h1>Welcome to IoT Stock Management staff member: <%=Name%> </h1>
<h2><a href="add-product.jsp">Add Product</a></h2>
<h2><a href="remove-product.jsp">Remove Product</a></h2>

</body>
</html>

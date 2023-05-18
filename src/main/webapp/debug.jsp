<%--
  Created by IntelliJ IDEA.
  User: byronlester
  Date: 12/5/2023
  Time: 2:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <%
    String type = (String) session.getAttribute("type");
    String name = (String) session.getAttribute("name");
    String password = (String) session.getAttribute("password");%>
    <title>Debug</title>
</head>
<body>
<p>Name = <%=name%> Type = <%=type%> Password = <%=password%></p>

</body>
</html>

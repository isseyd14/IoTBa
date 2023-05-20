<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%
    String email = (String) session.getAttribute("email");
    String name = (String) session.getAttribute("name");
                String errorMessage3 = (String) session.getAttribute("errorMessage3");

    if(email == null){

   
%>

<body>Error no Login</body>

<%} else if(email != null){

%>
<head>
    <title><%out.print(name);%> - Your Account</title>
    <link rel="stylesheet" href="topbar.css">
</head>
<style>
    .mainHead{
        display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  margin: 50px;
  padding: 30px;
  border-radius: 40px;
  background-color: #efefef76;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.03), 0 8px 16px rgba(0, 0, 0, 0.03);
                      }

    .titleSubheading{
        font-size: 14px;
        color:#767676;
        margin:0px;
        margin-top:30px;
        padding:0px;
    }

    .titleHeading{
        font-size: 24px;
        margin:0px;
        padding:0px;
        color:#363636;
    }

    .button{
        width:100%;
        margin-left:50px;
        margin-right:50px;
        margin-top:50px;
        
        height:50px;
        display: flex;
        justify-content: center;
        align-items:center;
        font-size: 18px;
    }
</style>

<body>

<nav class="standard-Nav">
    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    <ul class="nav-links">
      <li class="nav-button" style="min-width:400px; "><a href="account.jsp"
          style="background-color: #ff000000; color:black;">Welcome, <%out.print(name);%></a></li>
      <li class="nav-button"><a href="home.jsp">Search</a></li>

      <li class="nav-button"><a href="logout">Logout</a></li>
    </ul>
  </nav>

  <div class="mainHead" >
    <div style="margin-bottom:100px;" >
        <h3 class="titleSubheading" >Name</h3>
        <h3 class="titleHeading" style="font-size: 28px;"><%out.print(name);%></h3>
        <h3 class="titleSubheading" style=" margin-top:30px;">Email</h3>
<h3 class="titleHeading" style="font-size: 28px;"> <%out.print(email);%></h3>
        </div>

<a  type="submit" href="edit_info.jsp"  class="button ">Edit My Information</a>
<a  type="submit" href="delete_acc.jsp"  class="button ">Delete My Account</a>
<<<<<<< Updated upstream
<br>
<a  type="submit" href="AccessLogServlet"  class="button ">View Past Account Activity</a>
    <form action="Deletepaymentservlet" method="Post">
         <input type="submit" value="Delete Payment Info">
    </form>
<% if(errorMessage3 != null) { %>
    <p style="color: red"><%=errorMessage3%></p> <% } %>
        


=======
>>>>>>> Stashed changes

<a  type="submit" href="AccessLogServlet"  class="button ">View Past Account Activity</a>
</div>
</body>
<%}
%>
</html>
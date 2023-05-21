<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

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
    <link rel="stylesheet" href="topbar.css">
</head>
<style>
  body{
  background-color: #034473;
}

.standard-Nav {
    display: flex;
    height: 70px;
    background-color: #f3f3f3;
    box-shadow: 0px -10px 36px 3px rgba(143, 142, 142, 0);
    
}
  .submitsection{
    position:fixed;
    width:100vw;
    bottom:0;
    height:100px;
    background-color: #f4f4f4;


    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);



    padding-right:40px;
    
    display:flex;

    display:none;
  }
  .submitDiv{

    display: flex;
 padding-right:70px;
    align-items: center;
    margin-top:auto;
    margin-bottom:auto;
    margin-left:auto;

  }

  .button{
    
    height:50px;
    margin-right:50px;

  }

  .mainContent{

  }

  .formContent{
padding-top:50px;
  display: flex;
  align-items: center;
  justify-content: top;
  flex-direction: column;
  margin-left:auto;
  margin-right:auto;
max-width:800px;
height:100%;
  background-color: #f3f3f3;

  }

  .nav-links .nav-button a {
  color:#034473; 
background-color:#509e6000; 
 border-right: 2px solid #034473; 


}

.nav-links .nav-button a:hover {
    background-color: #0c78c578;
}
</style>
<body>
    <body>
        <nav class="standard-Nav">
          <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
          <ul class="nav-links">
            <li class="nav-button" style="min-width:400px; "><a href="account.jsp"
                style="background-color: #ff000000; color:black;">Welcome, <%out.print(name);%></a></li>
            <li class="nav-button"><a href="home.jsp">Search</a></li>
      
            <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
          </ul>
        </nav>
<div class="mainContent">


<form method="post" action="Deletepaymentservlet" name="deletePay" onsubmit="return confirm('Are you sure you wish to proceed? There is no going back from here...');">
    <div class="formContent">

        <h3 style="text-align: center; margin-bottom:50px;">This action will irreversibly delete your payment information from IoTBay </h3>

    <label style="padding-right:50px;">Confirm Password:</label>
    <input type="password" class="inputField" name="password" placeholder="password" required><br><br>
</div>
    <div class="submitsection">
        <div class="submitDiv">
    <input type="submit" class="button" value="Yes, Proceed">
    <a type="button" href="account.jsp" style="padding-top:5px;text-decoration: none; color:#545454;">No, Never mind</a>
    </div>
</div>
</form>
</div>
</body>
<%}
%>
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
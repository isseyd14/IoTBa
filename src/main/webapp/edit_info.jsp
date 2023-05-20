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


    padding-top:40px;
    padding-right:40px;
    
    display:flex;

    display:none;
  }

  .submitDiv{
    margin-left:auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-right:100px;
    

  }
  

.form-table{

  display: flex;
  justify-content: center;
  margin-left:auto;
  margin-right:auto;

  height:500px;
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

.innerBody{
  display: flex;
  justify-content: center;
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
  <nav class="standard-Nav">
    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    <ul class="nav-links">
      <li class="nav-button" style="min-width:400px; "><a href="account.jsp"
          style="background-color: #ff000000; color:black;">Welcome, <%out.print(name);%></a></li>
      <li class="nav-button"><a href="home.jsp" style="">Search</a></li>

      <li class="nav-button" ><a href="logout" style="color:#034473; background-color:#509e6000;">Logout</a></li>
    </ul>
  </nav>


<div class="mainContent">
<form method="post" action="EditInfoServlet" name="EditInfo">
  <div class="innerBody">
  <table class="form-table">
    <tr>
      <td>
        <h2>Password</h2>
      </td>
    </tr>
    <tr>
      <td>
        <label>Confirm Current Password:</label>
      </td>
      <td>
        <input class="inputField" type="password" name="current_pwd"  placeholder="password" required>
      </td>
    </tr>
    <tr>
      <td>
        <label>New Password:</label>
      </td>
      <td>
        <input class="inputField" type="password" placeholder="password" name="new_pwd">
      </td>
    </tr>
    <tr>
      <td>
        <h2>Contact</h2>
      </td>
    </tr>
    <tr>
      <td>
        <label>New Name:</label>
      </td>
      <td>
        <input class="inputField" type="text" name="new_name" placeholder="name">
      </td>
    </tr>
    <tr>
      <td>
        <label>New Email:</label>
      </td>
      <td>
        <input class="inputField" type="text" name="new_email" placeholder="email">
      </td>
    </tr>
  </table>
</div>
    <div class="submitsection">
      <div class="submitDiv">
        <input type="submit"  class="button" value="Edit">
        <a type="button"  href="account.jsp" style="padding-top:5px;text-decoration: none; color:#545454;" >Cancel</a>
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
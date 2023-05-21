<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>IoTBay</title>
</head>
<body>


<link rel="stylesheet" href="topbar.css">
</body>
</html>


<style>
     .nav-logo{
        margin-left:auto;
        margin-right:auto;
      }
body {
    background-color: #f2f2f2;
    font-family: Arial, sans-serif;
}

form {
    width: 300px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
}

label {
    font-weight: bold;
    display: block;
    margin-bottom: 10px;
}

a[type="text"], input[type="password"] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
}


a[type="text"]:focus, input[type="password"]:focus {
    border: 2px solid #034473;
}

      
a {
   color: #474747;
}

.container {
    text-align: center;
    margin-top: 50px;
    padding:100px;
}

h1 {
    font-size: 36px;
    margin-bottom: 20px;
    text-align: center;
}

/* Add a shadow effect to the form */
form {
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
}


/* Add a font awesome icon to the submit button */
input[type="submit"]::before {
  content: "\f093";
  font-family: "Font Awesome 5 Free";
  font-weight: 900;
  margin-right: 10px;
}

/* Add a custom cursor for the submit button */
input[type="submit"] {
    cursor: pointer;
}

.button{
    height:50px;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    font-size: 20px;
}
</style>

<nav class="standard-Nav">
    <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    
  </nav>

  <div style="margin-top:100px; margin-bottom:-20px; color:#2e2e2e;">
  <h1 style=" text-align: center;">Welcome to IOT Bay.  </h1>
  <h2 style=" text-align: center;">Create an account to view our amazing stock!!</h2>
</div>

<div class="container">

<form style="padding: 50px; display: flex; flex-direction: column; align-items: center;">
    <a  type="submit" href="register.jsp"  class="button ">Create an account</a>
 <a  type="submit" href="login.jsp" style="margin-top:40px; margin-bottom:0px;">I am already a member</a>
 <br>
 <br>
 <br>
    
  
    
</form>

</div>

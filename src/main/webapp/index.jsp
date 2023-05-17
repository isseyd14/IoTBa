<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>IoTBay</title>
</head>
<body>
<img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
<h1>IoTBay</h1>

</body>
</html>


<style>
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

a[type="submit"] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;

}
a[type="text"]:focus, input[type="password"]:focus {
    border: 2px solid #4CAF50;
}

a:hover {
    background-color: #45a049;
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


</style>



<div class="container">

<form >
 <a  type="submit" href="login.jsp"  class="button ">Login</a>
 <br>
 <br>
 <br>
    <a  type="submit" href="register.jsp"  class="button ">Register</a>
  
    
</form>

</div>

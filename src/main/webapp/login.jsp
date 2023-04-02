<!DOCTYPE html>
<html>
<head>
    <title>IoT Bay - Login</title>
    <link rel="stylesheet" type="text/css" href="loginStyles.css?<?php echo time(); ?>">
</head>
<body>
    
     <%
            String loginError = (String) session.getAttribute("InvalidLogin");
      %>
<h1>Login</h1>
<form method="post" action="LoginServlet" name="login" onsubmit="return validateForm()">
    <label>Email:</label>
    <input type="text" name="email"><br><br>

    <label>Password:</label>
    <input type="password" name="password"><br><br>



    <input type="submit" value="Login">
</form>


<script>

    function validateForm() {
        let email = document.forms["login"]["email"].value;
        let password = document.forms["login"]["password"].value;

        if(email == "" || password == "" ) {
            alert("Please enter a valid username or password.")
            return false;
        }
    }





</script>

</body>

</html>

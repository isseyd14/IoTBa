<!DOCTYPE html>
<html>
<head>
  <title>IoT Bay - Login</title>
  <link rel="stylesheet" type="text/css" href="loginStyles.css">
</head>
<body>
<h1>Login</h1>
<form method="post" action="welcome.jsp" name="registration" onsubmit="return validateForm()">
  <label>Email:</label>
  <input type="text" name="email"><br><br>

  <label>Password:</label>
  <input type="password" name="password"><br><br>

  <input type="submit" value="Login">
</form>


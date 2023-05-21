<!DOCTYPE html>
<html>
<head>
  <title>IoT Bay Registration</title>
  <link rel="stylesheet" type="text/css" href="loginStyles.css?<?php echo time(); ?>">
  <link rel="stylesheet" href="topbar.css">
</head>


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
  
  input[type="text"], input[type="password"] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
  }

      
  input[type="submit"] {
      width: 100%;
      background-color: #034473;
      
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
  }
  input[type="text"]:focus, input[type="password"]:focus {
      border: 2px solid #034473;
  }
  
  input[type="submit"]:hover {
    background-color: #4494d5;
  }
  
  .container {
      text-align: center;
      margin-top: 50px;
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
  
<body>

  <nav class="standard-Nav">
    <img  class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
    
  </nav>
    <!--onsubmit="return validateForm()"-->
<h1>Registration</h1>
<form method="post" action="RegisterServerlet" name="registration" >
  <label>Email:</label>
  <input type="text" name="email" required ><br><br>

  <label>Name:</label>
  <input type="text" name="fname" required><br><br>

  <label>Password:</label>
  <input type="password" name="password" required><br><br>

  <label>Gender:</label>
  <input type="radio" name="gender" value="male">Male
  <input type="radio" name="gender" value="female">Female<br><br>

  <label>Agree to terms of Service:</label>
  <input type="checkbox" name="tos" value="agree" required><br><br>


  <!-- <input type="hidden" name="name" value="${param.name}" />
                <input type="hidden" name="email" value="${param.email}" />
                <input type="hidden" name="favcol" value="${param.favcol}" /> -->




  <input type="submit" value="Register">
</form>


</body>
</html>


<!DOCTYPE html>
<html>
<head>
  <title>IoT Bay Registration</title>
  <link rel="stylesheet" type="text/css" href="loginStyles.css?<?php echo time(); ?>">
</head>
<body>
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
  <input type="checkbox" name="tos" value="agree"><br><br>


  <!-- <input type="hidden" name="name" value="${param.name}" />
                <input type="hidden" name="email" value="${param.email}" />
                <input type="hidden" name="favcol" value="${param.favcol}" /> -->




  <input type="submit" value="Register">
</form>

<!--
<script>
  function validateForm() {
    var email = document.forms["registration"]["email"].value;
    var name = document.forms["registration"]["name"].value;
    var password = document.forms["registration"]["password"].value;
    var gender = document.querySelector('input[name="gender"]:checked');
    // gender = gender ? gender.value : null;
    var tos = document.forms["registration"]["tos"].checked;


    console.log("Email: " + email);
    console.log("Name: " + name);
    console.log("Password: " + password);
    console.log("Terms of Service: " + tos);

    if (email == "" || name == "" || password == "" || gender == null || !tos) {
      alert("Please fill out all fields and agree to the terms of service!");
      return false;
    }
  }
</script>-->


</body>
</html>


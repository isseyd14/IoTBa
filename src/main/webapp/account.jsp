<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <% String email=(String) session.getAttribute("email"); String name=(String) session.getAttribute("name"); 
    String errorMessage3 = (String) session.getAttribute("errorMessage3"); if(email==null){ %>

        <body>Error no Login</body>

        <%} else if(email !=null){ %>
                            
            <head>
                <title>
                    <%out.print(name);%> - Your Account
                </title>             
                <link rel="stylesheet" href="topbar.css">
            </head>
            <style>
                .mainHead {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: space-between;
                    padding-top: 50px;  
                    margin: 150px;   
                    border-radius: 40px;
                    background-color: #ffffff76;
                    box-shadow: 0 4px 15px 0 rgba(0, 0, 0, 0.157);
                }

                .titleSubheading {
                    font-size: 14px;
                    color: #767676;
                    margin: 0px;
                    margin-top: 30px;
                    padding: 0px;
                }

                .titleHeading {
                    font-size: 24px;
                    margin: 0px;
                    padding: 0px;
                    color: #363636;
                }

            
                .buttons{
                    
    border: none;
    border-radius: 30px;
    background-color: #034473;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
  
    text-decoration: none;
    display: flex;
                    justify-content: center;
                    align-items: center;
                    max-width: 100%;
                    width: 90%;
                    height:80px;
                    margin-top: 50px;
                    margin-right:auto;
                    margin-left:auto;
                }


                .buttonsDiv{
            
                    width:100%;
                    margin-left:30px;
                    margin-right:30px;
                }
            </style>

            <body>
                                                                 <p>${errorMessage3}</p>

                <nav class="standard-Nav">
                    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">
                    <ul class="nav-links">
                        <li class="nav-button" style="min-width:400px; "><a href="account.jsp"
                                style="background-color: #ff000000; color:black;">Welcome, <%out.print(name);%></a></li>
                        <li class="nav-button"><a href="home.jsp">Search</a></li>

                        <li class="nav-button"><a href="LogoutServlet">Logout</a></li>
                    </ul>
                </nav>

                <div class="mainHead">
                    <div style="margin-bottom:100px;">
                        <h3 class="titleSubheading">Name</h3>
                        <h3 class="titleHeading" style="font-size: 28px;">
                            <%out.print(name);%>
                        </h3>
                        <h3 class="titleSubheading" style=" margin-top:30px;">Email</h3>
                        <h3 class="titleHeading" style="font-size: 28px;">
                            <%out.print(email);%>
                        </h3>
                    </div>
                        


                    <div class="buttonsDiv">
                    <a type="submit" href="edit_info.jsp" class="buttons ">Edit My Information</a>
                    <a type="submit" href="delete_acc.jsp" class="buttons ">Delete My Account</a>

           
                    <a type="submit" href="AccessLogServlet" class="buttons ">View Past Account Activity</a>
                    
                    <a type="submit" href="DeletePayment.jsp" class="buttons ">Delete Payment Information</a>

                 
                  


                    </div>
                </div>
            </body>
            <%} %>

    </html>
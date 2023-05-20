<%@ page import="java.util.ArrayList" %>
  <%@ page import="java.text.Format" %>
    <%@ page import="java.text.SimpleDateFormat" %>
      <%@ page import="java.sql.Date" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
          <html>
          <style>

          </style>
          <% String email=(String) session.getAttribute("email"); String name=(String) session.getAttribute("name");
            ArrayList<Long> loginTimes = (ArrayList<Long>) session.getAttribute("login_times");
              ArrayList<Long> logoutTimes = (ArrayList<Long>) session.getAttribute("logout_times");
                  Format format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                  if(email == null){
                  %>

                  <body>Error no Login</body>

                  <%} else if(email !=null){ %>

                    <head>
                      <title>
                        <%out.print(name);%> - Your Account
                      </title>

                      <link rel="stylesheet" href="topbar.css">
                    </head>
                    <style>
                      .bodyContent{
                        margin-top:50px;
                      }
                      .mainHead{
                        display:flex;
                        align-items: center;
                        justify-content: space-between;
                        margin:50px;
                        padding:30px;
                        box-shadow: 0 4px 15px 0 rgba(0, 0, 0, 0.157);
                        border-radius: 40px;
                        background-color: #ffffff76;

                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.03), 0 8px 16px rgba(0, 0, 0, 0.03);
                      }
                      .lowerBody{
                        display:flex;
                        align-items: center;
                        justify-content: space-between;
                   
                        margin-top:0px;
                        margin-left:50px;
                        margin-right:50px;
                        padding:30px;

                        border-radius: 20px;
                        background-color: #efefef76;

                       
                      }

                      .bodyTablerow{
                        background-color: white;
                        height:40px;
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
                      <div class="bodyContent">

                      <div class="mainHead mainHeadcolor">

                        <div>
                          <h3 class="titleSubheading" >Name</h3>
                          <h3 class="titleHeading"><%out.print(name);%></h3>
                          <h3 class="titleSubheading" style=" margin-top:30px;">Email</h3>
                  <h3 class="titleHeading" > <%out.print(email);%></h3>
                      

                        </div>

                        <div>
                          <a type="submit" href="edit_info.jsp" class="button ">Edit My Information</a>
                          <a type="submit" href="delete_acc.jsp" class="button ">Delete My Account</a>
                        </div>
                      </div>
                      <br>


                      <div class="lowerBody">
                      <table>
                        <tr >
                          <th>Login Time</th>
                          <th>Logout Time</th>
                        </tr>
                    <% for(int i=0; i < loginTimes.size(); ++i) {%> 
                          <tr class="bodyTablerow">
                            <td>
                              <% out.print(format.format((new Date(loginTimes.get(i))))); %>
                            </td>
                            <td>
                              <% out.print(format.format((new Date(logoutTimes.get(i))))); %>
                            </td>
                          </tr>
                          
                          <%}%>
                      </table>
                  </div>
                    </div>
                    </body>
                    <%} %>

          </html>
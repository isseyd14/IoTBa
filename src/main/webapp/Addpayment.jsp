<%-- Document : Addpayment Created on : 14 May 2023, 7:25:47 pm Author : issey --%>

    <%@ page import="java.sql.*" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>


            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Add/update payment Details</title>
                <link rel="stylesheet" href="topbar.css">
            </head>

            <style>
             
 

             .mainContent{
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

  margin-left:auto;
  margin-right:auto;
max-width:800px;
min-height:100%;
height:100%;
  background-color: #f3f3f3;
  padding:50px;
}

.nav-links .nav-button a {
  color:#034473; 
background-color:#509e6000; 
 border-right: 2px solid #034473; 


}

.nav-links .nav-button a:hover {
    background-color: #0c78c578;
}

.tableContainer{
  width: 100%;
  overflow-x: auto;
}

      
      .stock-table th,
      .stock-table td {
      font-size: 10px;
      }
   
  
      
      .stock-table .table-actions .quantity {
        font-size: 10px;
        color: #888888;
      }
      .button{
       margin:40px;
      }
   
      form{
        display: flex;
       align-items: center;

        flex-direction: column;
      }
      .nav-logo{
        margin-left:auto;
        margin-right:auto;
      }
      .mainContent{
        
      }

      .submitsection{
    position:fixed;
    width:100vw;
    bottom:0;
    height:90px;
    background-color: #f4f4f4;


    box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);


    padding-top:20px;
    padding-right:20px;
    
    display:flex;
align-items: center;
    display:none;
  }

  .submitDiv{
    margin-left:auto;
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-right:100px;
    

  }
            </style>

            <body>


                <nav class="standard-Nav">
                    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60" alt="Product Image">

                </nav>
                
                <nav class="standard-Nav">
                <ul class="nav-links">
                <li class="nav-button"><a href="home.jsp">Home</a></li>
                <li class="nav-button"><a href="account.jsp">Account</a></li>
                </ul>
                </nav>



                <% String CCNEr=(String) session.getAttribute("CCNE"); String CCEEr=(String)
                    session.getAttribute("CCEE"); String CCCVCr=(String) session.getAttribute("CCCVC"); String
                    name=(String) session.getAttribute("Name"); String email=(String) session.getAttribute("email");
                    String CCM=(String) session.getAttribute("CCMsg"); Connection con=null; PreparedStatement ps=null;
                    ResultSet rs=null; %>

                    <% String currentEmail=(String) session.getAttribute("email"); try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con=DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin"
                        , "iotBaypassword1" ); String sql="SELECT * FROM u236601339_iotBay.PaymentInfo WHERE Email=?" ;
                        ps=con.prepareStatement(sql); ps.setString(1, currentEmail); rs=ps.executeQuery();}
                        //if(!rs.next()){ // request.setAttribute("errorMessage1", "No Payment of this type" ); // } }
                        catch(SQLException e) { } %>


                        <div class="mainContent">
                            <div class="innerBody">
                        <h2>Add/Update Payment</h2>
                        <form action="AddPaymentServlet" method="post">
                            <div>
                            </div>
                            <%if(rs.next()){%>
                                <table>
                                    <tr>
                                        <td><label for="CCNE">Credit Card Number</label></td>
                                        <td><input class="form_input_box inputField" type="text" id="frame" name="CCNE"
                                                value=<%=rs.getString("CardNumber")%> required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="CCEE">Credit Card Expiry</label></td>
                                        <td><input class="form_input_box inputField" type="text" id="frame" name="CCEE"
                                                value=<%=rs.getString("Expdate")%> required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="CCCVC">Credit Card CVC</label></td>
                                        <td><input class="form_input_box inputField" type="text" id="frame" name="CCCVC"
                                                value=<%=rs.getString("CVC")%> required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="Name">Name</label></td>
                                        <td><input class="form_input_box inputField" type="text" id="frame" name="Name"
                                                value=<%=rs.getString("Name")%> required></td>
                                    </tr>
                                        <p>${CCMsg}</p>

                                    <tr>
                                        <td></td>
                                        <td>
                                         
                                        </td>
                                    </tr>

                                </table>


                                    <input class="button" type="submit" value="Add/Confirm" required>
                                <%} else{%>

                                    <table>
                                        <tr>
                                            <td><label for="CCNE">Credit Card Number</label></td>
                                            <td><input class="form_input_box inputField" type="text" id="frame" name="CCNE"
                                                    placeholder="<%=(CCNEr != null ? CCNEr : "0055435156548569")%>"
                                                required></td>
                                        </tr>
                                        <tr>
                                            <td><label for="CCEE">Credit Card Expiry</label></td>
                                            <td><input class="form_input_box inputField" type="text" id="frame" name="CCEE"
                                                    placeholder="<%=(CCEEr != null ? CCEEr : "12/24")%>" required></td>
                                        </tr>
                                        <tr>
                                            <td><label for="CCCVC">Credit Card CVC</label></td>
                                            <td><input class="form_input_box inputField" type="text" id="frame" name="CCCVC"
                                                    placeholder="<%=(CCCVCr != null ? CCCVCr : "161")%>" required></td>
                                        </tr>
                                        <tr>
                                            <td><label for="Name">Name</label></td>
                                            <td><input class="form_input_box inputField" type="text" id="frame" name="Name"
                                                    placeholder="<%=(name != null ? name : " jack smith")%>" required>
                                            </td>
                                            <p>${CCMsg}</p>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>

                                            <input class="" type="submit" value="Add/Confirm" required>
                                </form>
                                    <%}%>
                                </div>
                                </div>
            </body>

            </html><!--<script>
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
              </script> -->

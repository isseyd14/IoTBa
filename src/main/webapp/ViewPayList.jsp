<%-- 
    Document   : ViewPayList
    Created on : 18 May 2023, 2:13:36 pm
    Author     : issey
--%>
<%@ page import="grp4.iotbay.Model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Payment Details</title>
        <link rel="stylesheet" href="topbar.css">
    </head>
    <style>
        body {
      background-color: #034473;
  }

  .mainContent {
      background-color: #034473;
  }

  .standard-Nav {
      display: flex;
      height: 70px;
      background-color: #f3f3f3;
      box-shadow: 0px -10px 36px 3px rgba(143, 142, 142, 0);

  }

  .submitsection {
      position: fixed;
      width: 100vw;
      bottom: 0;
      height: 100px;
      background-color: #f4f4f4;


      box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);


      padding-top: 40px;
      padding-right: 40px;

      display: flex;

      display: none;
  }

  .submitDiv {
      margin-left: auto;
      display: flex;
      flex-direction: row;
      align-items: center;
      margin-right: 100px;


  }


  .form-table {

      display: flex;
      justify-content: center;
      margin-left: auto;
      margin-right: auto;

      height: 500px;
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

  .innerBody {
      margin-top: 40px;
      margin-left: auto;
      margin-right: auto;
      max-width: 800px;
      min-height: 100%;
      background-color: #f3f3f3;
      padding: 50px;
  }

  .nav-links .nav-button a {
      color: #034473;
      background-color: #509e6000;
      border-right: 2px solid #034473;


  }

  .nav-links .nav-button a:hover {
      background-color: #0c78c578;
  }

  .tableContainer {
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

  .button {
      margin: 40px;
  }

  form {
      display: flex;
      align-items: center;

      flex-direction: column;
  }

  .nav-logo {
      margin-left: auto;
      margin-right: auto;
  }

  .mainContent {
      margin-top: 40px;
  }

  .inputField{
    background-color: white;
  }
</style>
<nav class="standard-Nav">
    <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60"
        alt="Product Image">

</nav>
<div class="mainContent">

    <h2><a href="home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Home</a></h2>
    <div class="innerBody">
 
        <h1>Current Payment Details</h1>
        <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        %>
        
        <%
        session.setAttribute("referringFile1123", "ViewPayList.jsp");
        List<Pay> pays = (LinkedList<Pay>) session.getAttribute("pay");
        String currentEmail = (String) session.getAttribute("email");
        String errorMessage5 = (String) session.getAttribute("errorMessage5");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "SELECT * FROM u236601339_iotBay.PaymentInfo WHERE Email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            rs = ps.executeQuery();
            //if(!rs.next()){
              //  request.setAttribute("errorMessage1", "No Payment of this type");  
          //  }

        %>
        
            <table>
            <% if(rs.next()) { %>
               <tr>
                <th>Credit Card Number</th>
                <th>Credit Card Expiry</th>
                <th>Credit Card CVC</th>
                <th>Name</th>
            </tr>
            <tr>
                <td><%= rs.getString("CardNumber") %></td>
                <td><%= rs.getString("Expdate") %></td>
                <td><%= rs.getString("CVC") %></td>
                <td><%= rs.getString("Name") %></td>
            </tr>
            <% } else{%>
            No payment information was found
            <%} } finally{
                try {
                    if(rs != null) {
                        rs.close();
                    }
                    if(ps != null) {
                        ps.close();
                    }
                    if(con != null) {
                        con.close();
                    }
                }catch (SQLException e) {
    throw new RuntimeException(e);
}
            }%>
            
             <% if(pays == null) { %>
            <% try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            String sql = "SELECT * FROM u236601339_iotBay.Payment WHERE Email=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, currentEmail);
            rs = ps.executeQuery();

            }
                catch(SQLException e) {
        }
          

        %>
       <%}%>
 
<% if(errorMessage5 != null) { %>
    <p style="color: red"><%=errorMessage5%></p> <% } %>
    <hr>
    <form action="FilterPayServlet" method="get">
        <label>Search by Pay ID: </label>
        <input type="text" name="payID" class="inputField"><br>
        <label>Search by Date: </label>
        <input type="text" name="Paydate" class="inputField"><br>
        <input type="submit" value="Filter" class="button">
    </form>
        <hr>

     <form action="ResetPayFilter" method="get">
        <input type="submit" value="Reset" class="button" >
    </form>
            <hr>

            <h1>Payment History</h1>

    <% if(pays == null) { %>

    <table class="stock-table">
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Amount</th>

        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("PayID") %></td>
            <td><%= rs.getString("Date")%></td>
            <td>$<%= rs.getString("Amount")%></td>

        </tr>
        <% }
            if(con != null) {
                con.close();
            }%>
    </table> <% } else { %>

    <table class="stock-table">
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Amount</th>
        </tr>
        <%for(Pay product : pays) { %>
        <td><%=product.getID() %></td>
        <td><%=product.getCreated()%></td>
        <td>$<%=product.getAmount()%></td>
        </tr>
        <% }
        }%>
    </table>
</div>

    </div>
    </body>
</html>

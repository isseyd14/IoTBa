<%-- 
    Document   : orders
    Created on : 18 May 2023, 10:01:09 am
    Author     : Rhys
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="grp4.iotbay.Model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
    </head>
        <style>
    .stock-table {
        border-collapse: collapse;
    }

    .stock-table td, .stock-table th {
        border: 1px solid black;
        padding: 0.5rem;
    }
</style>

    <%
        int userId = (int) request.getSession().getAttribute("userId");
        Connection con ;
        PreparedStatement pst ;
        PreparedStatement pst2 ;

        ResultSet rs ;
        ResultSet rs2 ;

        String query ;
        String query2 ;
        con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
    
    
    List<Order> list = new ArrayList<>();
        try {
            query = "SELECT * FROM u236601339_iotBay.order WHERE customerId=? ORDER BY order.orderId DESC";
            pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                Product row = null;
                query2 = "SELECT * FROM u236601339_iotBay.product WHERE productId=? ";
            int pId = rs.getInt("productId");
            pst2 = con.prepareStatement(query2);
            pst2.setInt(1, pId);
            rs2 = pst2.executeQuery();
            while (rs2.next()) {
	            	row = new Product();
	                row.setId(rs2.getInt("productId"));
	                row.setName(rs2.getString("productName"));
	                row.setType(rs2.getString("productType"));
	                row.setDescription(rs2.getString("productDescription"));
	                row.setPrice(rs2.getDouble("productPrice"));
	            }
                
//                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("orderId"));
                order.setId(pId);
                order.setName(row.getName());
                order.setType(row.getType());
                order.setDescription(row.getDescription());
                order.setPrice(row.getPrice());
                order.setDate(rs.getString("orderDate"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    %>
    <body>
        <h1>IoT Bay Webstore</h1>
        <h2><a href="home.jsp">Home</a></h2>
        <h2>My Orders</h2>
        <%if(list != null){%>
        
        <div>
            <table class="stock-table">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
            <th>Unit Price</th>            
            <th>Order Date</th>

            <th></th>
        </tr>
        <% for(Order orderList : list) { %>
        <tr> 
        <td><%=orderList.getName()%></td>
        <td><%=orderList.getType()%></td>
        <td><%=orderList.getDescription()%></td>
        <td>$<%=orderList.getPrice()%></td>        
        <td><%=orderList.getDate()%></td>

        <td><a href="">Cancel Order</a></td>
        </tr>
        <%}%>
    </table>

    
        </div>
    <%}else{%>
    <div>NO ORDERS</div>
    <%}%>
    </body>
</html>

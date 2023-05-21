<%-- Document : orders Created on : 18 May 2023, 10:01:09 am Author : Rhys --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ page import="java.sql.*" %>
            <%@ page import="grp4.iotbay.Model.*" %>
                <%@ page import="java.util.List" %>
                    <%@ page import="java.util.ArrayList" %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <title>Orders</title>
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
                                flex-direction: column;
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
                        </style>

                        <% int userId=(int) request.getSession().getAttribute("userId"); Connection con ;
                            PreparedStatement pst = null ; PreparedStatement pst2 = null ; ResultSet rs = null ; ResultSet rs2 = null ; String query
                            ; String query2 ;
                            con=DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin"
                            , "iotBaypassword1" ); List<Order> list = new ArrayList<>();
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

                                // Product product = productDao.getSingleProduct(pId);
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
                                finally {
                                    try {
                                        if(rs != null) {
                                            rs.close();
                                        }
                                        if(rs2 != null) {
                                            rs2.close();
                                        }
                                        if(pst != null) {
                                            pst.close();
                                        }
                                        if(pst2 != null) {
                                            pst.close();
                                        }
                                        if(con != null) {
                                            con.close();
                                        }
                                    } catch (SQLException e) {
                                        throw new RuntimeException(e);
                                    }
                                }
                                %>

                                <body>

                                    <nav class="standard-Nav">
                                        <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60"
                                            alt="Product Image">

                                    </nav>

                                    <div class="mainContent">





                                        <h2><a href="home.jsp" class="button" style=" margin:100px; top:50px; border:2px solid white;">Home</a>
                                        </h2>

                                        <div class="innerBody">
                                            <h2>My Orders</h2>
                                            <%if(list !=null){%>

                                            
                                                    <div class="tableContainer">
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
                                                                    <td>
                                                                        <%=orderList.getName()%>
                                                                    </td>
                                                                    <td style="max-width: 50px;">
                                                                        <%=orderList.getType()%>
                                                                    </td>
                                                                    <td>
                                                                        <%=orderList.getDescription()%>
                                                                    </td>
                                                                    <td style="max-width: 20px;">$<%=orderList.getPrice()%>
                                                                    </td>
                                                                    <td style="max-width: 30px;">
                                                                        <%=orderList.getDate()%>
                                                                    </td>

                                                                    <td style="min-width: 100px;"><a
                                                                            href="cancel-order?id=<%=orderList.getOrderId()%>">Cancel
                                                                            Order</a></td>
                                                                </tr>
                                                                <%}%>
                                                        </table>


                                                    </div>
                                                    <%}else{%>
                                                        <div>NO ORDERS</div>
                                                        <%}%>

                                                </div>
                                        </div>
                                </body>

                        </html>
<%-- Document : checkout Created on : 19 May 2023, 9:27:28 pm Author : Rhys --%>

    <%@ page import="java.sql.*" %>
        <%@ page import="grp4.iotbay.Model.Cart" %>
            <%@ page import="java.util.List" %>
                <%@ page import="java.util.ArrayList" %>

                            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                                    <title>Checkout</title>
                                    <link rel="stylesheet" href="topbdar.css">
                                </head>


                                <style>
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

                                        margin-left: auto;
                                        margin-right: auto;
                                        max-width: 800px;
                                        min-height: 100%;
                                        height: 100%;
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

                                    .mainContent {}

                                    .submitsection {
                                        position: fixed;
                                        width: 100vw;
                                        bottom: 0;
                                        height: 90px;
                                        background-color: #f4f4f4;


                                        box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);


                                        padding-top: 20px;
                                        padding-right: 20px;

                                        padding-left: 50px;
                                        padding-right: 50px;
                                        display: flex;
                                        align-items: center;

                                    }

                                    .submitDiv {
                                        margin-left: auto;
                                        display: flex;
                                        flex-direction: row;
                                        align-items: center;
                                        margin-right: 100px;
                                        justify-content: space-between;


                                    }


                                    .tableContainer {
                                        width: 100%;
                                        overflow-x: auto;
                                    }
                                </style>

                                <body>
                                    <nav class="standard-Nav">
                                        <img class="nav-logo" src="IotBayLogo.png" width="60px" height="60"
                                            alt="Product Image">
                                        <link rel="stylesheet" href="topbar.css">
                                    </nav>

                                    <div class="mainContent">
                                        <div class="innerBody">

                                            <h2>My Items</h2>

                                            <% ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
                                                Connection con = null;
                                                PreparedStatement pst = null ;
                                                ResultSet rs = null ;
                                                String query ;
                                                try {
                                                    con = DriverManager.getConnection(
                                                            "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                                                            "u236601339_iotbayAdmin", "iotBaypassword1"
                                                    );

                                            %>

                                            <%if (cart_list != null) {%>

                                            <div class="tableContainer">
                                                <table class="stock-table">
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Type</th>
                                                        <th>Description</th>
                                                        <th>Quantity</th>
                                                        <th>Unit Price</th>
                                                        <th></th>
                                                    </tr>
                                                    <% for (Cart product : cart_list) {
                                                        int id = (int) product.getId();
                                                        query = "SELECT * FROM product WHERE productId=?";
                                                        pst = con.prepareStatement(query);
                                                        pst.setInt(1, id);
                                                        rs = pst.executeQuery();
                                                        while (rs.next()) {%>
                                                    <tr>

                                                        <td style="max-width:80px;">
                                                            <%=rs.getString("productName") %>
                                                        </td>
                                                        <td style="max-width:50px;">
                                                            <%= rs.getString("productType")%>
                                                        </td>
                                                        <td style="max-width:150px;">
                                                            <%= rs.getString("productDescription")%>
                                                        </td>
                                                        <td style="max-width:10px;">1</td>
                                                        <td style="max-width:20px;">$<%= rs.getDouble("productPrice") %>
                                                        </td>
                                                        <td><a href="remove-cart?id=<%=id %>"
                                                               style="background-color: #ff000000;"><img
                                                                class="nav-logo" src="bin.png" width="20px" height="20"></a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <% double sum = 0;
                                                    for (Cart product : cart_list) {
                                                        int
                                                                id = (int) product.getId();
                                                        query = "SELECT productPrice FROM product WHERE productId=?";
                                                        pst = con.prepareStatement(query);
                                                        pst.setInt(1, id);
                                                        rs = pst.executeQuery();
                                                        while (rs.next()) {
                                                            sum += rs.getDouble("productPrice");
                                                        }
                                                    }
                                                    session.setAttribute("Amount", sum); %>

                                            </div>
                                        </div>
                                        <div class="submitsection">

                                            <div class="submitDiv">
                                                <h3>Total Price: $<%= sum %>
                                                </h3>

                                                <a href="cart-checkout" class="button"
                                                   style="text-align: center;">Order</a>


                                                <%} else {%>
                                                <div>NO ITEMS TO CHECKOUT</div>
                                                <%
                                                        }
                                                    } finally {
                                                            if(rs != null) {
                                                                rs.close();
                                                            }
                                                            if(pst != null) {
                                                                pst.close();
                                                            }
                                                            if(con != null) {
                                                                con.close();
                                                            }
                                                    }
                                                %>

                                                    </div>
                                                </div>
                                </body>

                                </html>

                                </html>
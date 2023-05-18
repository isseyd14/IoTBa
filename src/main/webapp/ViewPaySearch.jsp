<%-- 
    Document   : ViewPaySearch
    Created on : 18 May 2023, 2:13:53 pm
    Author     : issey
--%>
<%@ page import= "grp4.Model.Payment"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payments search</title>
    </head>
    <body>
     <form action="searchPaymentServlet" method="post">
            <table>
                <tr>
                    <th>Search</th>
                    <th> 
                        <select name="searchOption">
                            <option value="creditCardNumberSearch">Credit Card Number</option>
                            <option value="dateSearch">Date(dd-mm-yyyy)</option>
                        </select>
                    </th>
                    <th><input type="text" name="searchBox" required></th>
                    <th><input type="submit" name="submitSearch"></th>
                </tr>
            </table>
        </form>
        <table class="order_list_table">
            <tr>
                <th>Credit Card Number</th>
                <th>Credit Card Expiry</th>
                <th>Credit Card CVC</th>
                <th>Last modified</th>
                <th>Name</th>
            </tr>
            <%
                if (paymentList.size() > 0) {
                    for (int i = 0; i < paymentList.size(); i++) {
                        if (paymentList.get(i).getIsDefault() == 1) {
                            DefaultString = "True";
                        } else {
                            DefaultString = "False";
                        }
                        //For loop to iterate through the entire paymentList and convert the default varaible from a int to a String
            %>
            <tr>
                <td><%=paymentList.get(i).getCreditCardNumber()%></td>
                <td><%=paymentList.get(i).getCreditCardExpiry()%></td>
                <td><%=paymentList.get(i).getCreditCardCVC()%></td>
                <td><%=paymentList.get(i).getCreated()%></td>
                <td><%=paymentList.get(i).getLastUpdated()%></td>
                <td><%=DefaultString%></td>
                <td><a href="PaymentServlet?action=update&index=<%=i%>">Update</a></td><!--Sends information about which Payment has been selected for updates-->
                <td><a href="PaymentServlet?action=delete&number=<%=i%>">Delete</a></td> <!--This sends information about which Payment has been selected for deletion-->
            </tr>
            <%
                    }
                }
            %>
            <tr>
                <td colspan="8"><a href="addPayment.jsp">Add new payment</a></td><!--After the if statement so it is always present-->
            </tr>
        </table>
        <%
            } catch (Exception ex) {
                ;
            }
        } else {
        %>
        <h4>Please log in to load your Payment methods</h4><!--For anonymous customers-->
        <%
            }
        %>
    </body>
</html>

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package grp4.iotbay.Servlets;

import grp4.iotbay.Model.Cart;
import grp4.iotbay.Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Rhys
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/cart-checkout"})
public class CheckoutServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try(PrintWriter out = response.getWriter()){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        Date date = new Date();
                        Connection con = null;
                        PreparedStatement ps = null;
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
                        int userId = (int) request.getSession().getAttribute("userId");
			if(cart_list != null) {
				for(Cart c:cart_list) {
					Order order = new Order();
					order.setId((int) Math.round(c.getId()));
					order.setUid(userId);
//					order.setQunatity(c.getQuantity());
					order.setDate(formatter.format(date));
					
					try{
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
                                            String sql = "INSERT into u236601339_iotBay.order (productId, customerId, orderDate) values(?,?,?)";
                                            
                                            ps = con.prepareStatement(sql);
                                            ps.setInt(1, (int) Math.round(order.getId()));
                                            ps.setInt(2, order.getUid());
                                            ps.setString(3, order.getDate());
                                            ps.executeUpdate();
                                        } catch (ClassNotFoundException | SQLException ex) {
                                        Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
                                    }
					
				}
				cart_list.clear();
				response.sendRedirect("orders.jsp");
			}else {
				response.sendRedirect("cart.jsp");
			}
		}	
}

	
@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

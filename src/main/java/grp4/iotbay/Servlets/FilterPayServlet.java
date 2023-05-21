package grp4.iotbay.Servlets;

import grp4.iotbay.Model.Pay;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

@WebServlet("/FilterPayServlet")
public class FilterPayServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //String productName = request.getParameter("email");
        String productName = request.getParameter("payID");
        String productType = request.getParameter("Paydate");
        String currentEmail = (String) session.getAttribute("email");
        String referringFile = (String) session.getAttribute("referringFile1123");

        List<Pay> pay = new LinkedList<>();
        if (productName.isEmpty() && productType.isEmpty()) {
            session.setAttribute("pay", null);
            RequestDispatcher rd = request.getRequestDispatcher(referringFile);
            rd.forward(request, response);
        }
        Connection con;
        PreparedStatement ps;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver") ;
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * FROM u236601339_iotBay.Payment WHERE PayID=? AND Email=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                ps.setString(2, currentEmail);                
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage5", "Cannot find payment.");
                    session.setAttribute("pay", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    Pay product = new Pay();
                    product.setID(rs.getInt("PayID"));
                    product.setAmount(rs.getString("Amount"));
                    product.setCreated(rs.getString("Date"));
                    pay.add(product);
                    closeConnections(con, ps, rs);
                    session.setAttribute("pay", pay);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {

            }
        

        if(productName.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * FROM u236601339_iotBay.Payment WHERE Date=? AND Email=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productType);
                ps.setString(2, currentEmail);                
                ResultSet rs = ps.executeQuery();

                while(rs.next()) {
                    Pay product = new Pay();
                    product.setID(rs.getInt("PayID"));
                    product.setAmount(rs.getString("Amount"));
                    product.setCreated(rs.getString("Date"));
                    pay.add(product);
                }

                if(!pay.isEmpty()) {
                    closeConnections(con, ps, rs);
                    session.setAttribute("pay", pay);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage5", "Cannot find Payment.");
                    session.setAttribute("pay", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            }
            catch (SQLException | ClassNotFoundException e) {
            }
        }
        else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * FROM u236601339_iotBay.Payment WHERE PayID = ? AND Date=? AND Email=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                ps.setString(2, productType);
                ps.setString(3, currentEmail);                

                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage5", "Cannot find Payment.");
                    session.setAttribute("pay", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                     Pay product = new Pay();
                    product.setID(rs.getInt("PayID"));
                    product.setAmount(rs.getString("Amount"));
                    product.setCreated(rs.getString("Date"));
                    pay.add(product);
                    closeConnections(con, ps, rs);
                    session.setAttribute("pay", pay);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {

            }
        }
    }
    
    private void closeConnections(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
        if(con != null) {
            con.close();
        }
        if(ps != null) {
            ps.close();
        }
        if(rs != null) {
            rs.close();
        }
    }
}

<<<<<<< Updated upstream
package grp4.iotbay.Servlets;

import grp4.iotbay.Model.Product;
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

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productName = request.getParameter("productName");
        String productType = request.getParameter("productType");
        String referringFile = (String) session.getAttribute("referringFile");

        List<Product> products = new LinkedList<>();

        if (productName.isEmpty() && productType.isEmpty()) {
            session.setAttribute("products", null);
            RequestDispatcher rd = request.getRequestDispatcher(referringFile);
            rd.forward(request, response);
        }

        Connection con;
        PreparedStatement ps;

        if (productType.isEmpty()) {

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * from u236601339_iotBay.product where productName=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    Product product = new Product();
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setPrice(rs.getDouble("productPrice"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    products.add(product);
                    closeConnections(con, ps, rs);
                    session.setAttribute("products", products);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {

            }
        }

        if(productName.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * from u236601339_iotBay.product where productType=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productType);
                ResultSet rs = ps.executeQuery();

                while(rs.next()) {
                    Product product = new Product();
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    product.setPrice(rs.getDouble("productPrice"));
                    products.add(product);
                }

                if(!products.isEmpty()) {
                    closeConnections(con, ps, rs);
                    session.setAttribute("products", products);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
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

                String sql = "SELECT * from u236601339_iotBay.product where productName = ? AND productType=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                ps.setString(2, productType);

                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    Product product = new Product();
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setPrice(rs.getDouble("productPrice"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    products.add(product);
                    closeConnections(con, ps, rs);
                    session.setAttribute("products", products);
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
=======

package grp4.iotbay.Servlets;

import grp4.iotbay.Model.Product;
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

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productName = request.getParameter("productName");
        String productType = request.getParameter("productType");
        String referringFile = (String) session.getAttribute("referringFile");

        List<Product> products = new LinkedList<>();

        if (productName.isEmpty() && productType.isEmpty()) {
            session.setAttribute("products", null);
            RequestDispatcher rd = request.getRequestDispatcher(referringFile);
            rd.forward(request, response);
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        if (productType.isEmpty()) {

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * from u236601339_iotBay.product where productName=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                rs = ps.executeQuery();

                if (!rs.next()) {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    Product product = new Product();
                    product.setId(rs.getInt("productId"));
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setPrice(rs.getDouble("productPrice"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    products.add(product);
                    closeConnections(con, ps, rs);
                    session.setAttribute("products", products);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {

            }
            finally {
                closeConnections(con, ps, rs);
            }
        }

        if(productName.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * from u236601339_iotBay.product where productType=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productType);
                rs = ps.executeQuery();

                while(rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("productId"));
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    product.setPrice(rs.getDouble("productPrice"));
                    products.add(product);
                }

                if(!products.isEmpty()) {
                    closeConnections(con, ps, rs);
                    session.setAttribute("products", products);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    closeConnections(con, ps, rs);
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

            }
            catch (SQLException | ClassNotFoundException e) {

            }
            finally {
                closeConnections(con, ps, rs);
            }
        }

        else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                    "u236601339_iotbayAdmin", "iotBaypassword1"
                );

                String sql = "SELECT * from u236601339_iotBay.product where productName = ? AND productType=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, productName);
                ps.setString(2, productType);

                rs = ps.executeQuery();

                if (!rs.next()) {
                    request.setAttribute("errorMessage", "Cannot find product.");
                    session.setAttribute("products", null);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }

                else {
                    Product product = new Product();
                    product.setId(rs.getInt("productId"));
                    product.setName(rs.getString("productName"));
                    product.setType(rs.getString("productType"));
                    product.setDescription(rs.getString("productDescription"));
                    product.setPrice(rs.getDouble("productPrice"));
                    product.setQuantity(rs.getInt("productQuantity"));
                    products.add(product);
                    session.setAttribute("products", products);
                    RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                    rd.forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {

            }
            finally {
                closeConnections(con, ps, rs);
            }
        }

    }
    private void closeConnections(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if(ps != null) {
                ps.close();
            }
            if(rs != null) {
                rs.close();
            }
            if(con != null) {
                con.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
>>>>>>> Stashed changes

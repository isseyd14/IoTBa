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

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("name");
        String productType = request.getParameter("type");
        String productDesc = request.getParameter("description");
        String stringQuantity = request.getParameter("quantity");
        String stringPrice = request.getParameter("price");
        // Collect all form parameters.

        int productQuantity = 0;
        double productPrice = 0.0;

        String originalName = request.getParameter("originalName");
        String originalType = request.getParameter("originalType");
        String originalDesc = request.getParameter("originalDesc");
        int originalQuantity = Integer.parseInt(request.getParameter("originalQuantity"));
        double originalPrice = Double.valueOf(request.getParameter("originalPrice"));
        // Gather the original values of the product.

        if(productName.isEmpty() && productType.isEmpty() && productDesc.isEmpty() &&
            stringQuantity.isEmpty() && stringPrice.isEmpty()) {
            request.setAttribute("errorMessage", "Error: enter at least one value.");
            RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
            rd.forward(request, response);
            return;
            // If all values are empty, send error.
        }

        if(!stringQuantity.isEmpty()) { // Check that quantity value can be parsed as int. If not, return error.
            try {
                productQuantity = Integer.parseInt(stringQuantity);
            }
            catch(Exception e) {
                request.setAttribute("errorMessage", "Error: Incorrect data type for quantity and/or price.");
                RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
                rd.forward(request, response);
            }
        }

        if(!stringPrice.isEmpty()) { // Check that price value can be parsed as double. If not, return error.
            try {
                productPrice = Double.parseDouble(stringPrice);
            }
            catch(Exception e) {
                request.setAttribute("errorMessage", "Error: Incorrect data type for quantity and/or price.");
                RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
                rd.forward(request, response);
            }
        }

        Connection con = null;
        PreparedStatement ps = null;

        Product product = new Product();

        product.setName(originalName);
        product.setType(originalType);
        product.setDescription(originalDesc);
        product.setQuantity(originalQuantity);
        product.setPrice(originalPrice);
        // Set product object to be sent back as default, in case they do not get updated.

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false","u236601339_iotbayAdmin","iotBaypassword1");

            String query = "UPDATE product SET productName=?, productType = ?, productDescription = ?, productQuantity = ?, productPrice =?  WHERE productName = ?";

            ps = con.prepareStatement(query);

            if(!productName.isEmpty()) {
                ps.setString(1, productName);
                product.setName(productName);
            }
            else {
                ps.setString(1, originalName);
            }

            if(!productType.isEmpty()) {
                ps.setString(2, productType);
                product.setType(productType);
            }
            else {
                ps.setString(2, originalType);
            }

            if(!productDesc.isEmpty()) {
                ps.setString(3, productDesc);
                product.setDescription(productDesc);
            }
            else {
                ps.setString(3, originalDesc);
            }

            if(productQuantity != 0) {
                ps.setInt(4, productQuantity);
                product.setQuantity(productQuantity);
            }
            else {
                ps.setInt(4, originalQuantity);
            }
            if(productPrice != 0.0) {
                ps.setDouble(5, productPrice);
                product.setPrice(productPrice);
            }
            else {
                ps.setDouble(5, originalPrice);
            }

            ps.setString(6, originalName);

            ps.executeUpdate();

            HttpSession session = request.getSession();
            session.setAttribute("product", product);
            request.setAttribute("successMessage", "Update Success!");

            RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
            rd.forward(request, response);


        }
        catch(SQLException | ClassNotFoundException e) {
            request.setAttribute("errorMessage", "Error: could not connect to database/ could not find database driver.");
            RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
            rd.forward(request, response);
        }
        finally {
            try {
                if(ps != null) {
                    ps.close();
                }
                if(con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }

}

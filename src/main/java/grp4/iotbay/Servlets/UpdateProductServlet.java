package grp4.iotbay.Servlets;

import grp4.iotbay.Product;
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
        int productQuantity = Integer.parseInt(request.getParameter("quantity"));
        double productPrice = Double.parseDouble(request.getParameter("price"));

        String originalName = request.getParameter("originalName");
        String originalType = request.getParameter("originalType");
        String originalDesc = request.getParameter("originalDesc");
        int originalQuantity = Integer.parseInt(request.getParameter("originalQuantity"));
        Double originalPrice = Double.valueOf(request.getParameter("originalPrice"));

        if(productName.isEmpty() && productType.isEmpty() && productDesc.isEmpty() && productQuantity == 0 && productPrice == 0.0) {
            request.setAttribute("errorMessage", "Error: enter at least one value.");
            RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
            rd.forward(request, response);
            return;
        }

        Connection connection = null;
        PreparedStatement statement = null;

        Product product = new Product();

        product.setName(originalName);
        product.setType(originalType);
        product.setDescription(originalDesc);

        try {

            Class.forName("com.mysql.jdbc.Driver");

            connection = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false","u236601339_iotbayAdmin","iotBaypassword1");


            String query = "UPDATE product SET productName=?, productType = ?, productDescription = ?, productQuantity = ?, productPrice =?  WHERE productName = ?";

            statement = connection.prepareStatement(query);

            if(!productName.isEmpty()) {
                statement.setString(1, productName);
                product.setName(productName);
            }
            else {
                statement.setString(1, originalName);
            }

            if(!productType.isEmpty()) {
                statement.setString(2, productType);
                product.setType(productType);
            }
            else {
                statement.setString(2, originalType);
            }

            if(!productDesc.isEmpty()) {
                statement.setString(3, productDesc);
                product.setDescription(productDesc);
            }
            else {
                statement.setString(3, originalDesc);
            }

            if(productQuantity != 0) {
                statement.setInt(4, productQuantity);
                product.setQuantity(productQuantity);
            }
            else {
                statement.setInt(4, originalQuantity);
            }
            if(productPrice != 0.0) {
                statement.setDouble(5, productPrice);
                product.setPrice(productPrice);
            }
            else {
                statement.setDouble(5, originalPrice);
            }

            statement.setString(6, originalName);

            statement.executeUpdate();

            HttpSession session = request.getSession();
            session.setAttribute("product", product);
            request.setAttribute("successMessage", "Update Success!");

            connection.close();
            statement.close();

            RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
            rd.forward(request, response);


        }

        catch(SQLException | ClassNotFoundException e) {

        }


    }

}

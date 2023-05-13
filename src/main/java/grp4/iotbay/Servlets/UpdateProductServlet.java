package grp4.iotbay.Servlets;

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
        String productDescription = request.getParameter("description");

        if(productName == null && productType == null && productDescription == null) {
            request.setAttribute("statusMessage", "Error: enter at least one value.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("product-details.jsp");
            dispatcher.forward(request, response);
            return;
        }

       /* Product product = new Product();
        product.setName(productName);
        product.setType(productType);
        product.setDescription(productDescription); */

        Connection connection = null;
        PreparedStatement statement = null;

        try {

            Class.forName("com.mysql.jdbc.Driver");

            connection = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false","u236601339_iotbayAdmin","iotBaypassword1");

            String query = "UPDATE product SET productType = ?, productDescription = ?  WHERE productName = ?";

            statement = connection.prepareStatement(query);

            statement.setString(1, productType);
            statement.setString(2, productDescription);
            statement.setString(3, productName);

            statement.executeUpdate();


        }

        catch(SQLException | ClassNotFoundException e) {

        }


    }

}

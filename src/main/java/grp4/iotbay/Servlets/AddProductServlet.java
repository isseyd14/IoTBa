package grp4.iotbay.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String productName = request.getParameter("productName");
        String productType = request.getParameter("productType");
        String productDescription = request.getParameter("productDescription");
        String stringStock = request.getParameter("productStock");
        String stringPrice = request.getParameter("productPrice");
        int productStock = 0;
        double productPrice = 0.0;

        if(productName.isEmpty() || productType.isEmpty() || productDescription.isEmpty() || stringStock.isEmpty()
        || stringPrice.isEmpty()) {
            request.setAttribute("errorMessage", "Error: value missing. Please use all fields.");
            RequestDispatcher rd = request.getRequestDispatcher("add-product.jsp");
            rd.forward(request, response);
            return;
        }

        if(!stringStock.isEmpty()) {
            try {
                productStock = Integer.parseInt(stringStock);

            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Incorrect input for quantity or stock.");
                RequestDispatcher rd = request.getRequestDispatcher("add-product.jsp");
                rd.forward(request, response);
                return;
            }
        }

        if(!stringPrice.isEmpty()) {
            try {
                productPrice = Double.parseDouble(stringPrice);
            }
            catch(NumberFormatException e) {
                request.setAttribute("errorMessage", "Incorrect input for quantity or stock.");
                RequestDispatcher rd = request.getRequestDispatcher("add-product.jsp");
                rd.forward(request, response);
                return;
            }
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");

            String sql = "INSERT INTO u236601339_iotBay.product (productName, productType, productDescription, productQuantity, productPrice) VALUES (?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, productName);
            ps.setString(2, productType);
            ps.setString(3, productDescription);
            ps.setInt(4, productStock);
            ps.setDouble(5, productPrice);

            int rowsUpdated = ps.executeUpdate();

            if(rowsUpdated != 0) {
                request.setAttribute("successMessage", "Successfully added product to stock list!");
                RequestDispatcher rd = request.getRequestDispatcher("add-product.jsp");
                rd.forward(request, response);
            }

           response.sendRedirect("add-product.jsp");

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}

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

@WebServlet("/FindProductServlet")
public class FindProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");

        if(productName.isEmpty()) {
            request.setAttribute("errorMessage", "Error: please enter product name");
            RequestDispatcher rd = request.getRequestDispatcher("update-product.jsp");
            rd.forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        if(productName == null) {
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");

            String sql = "SELECT * FROM product WHERE productName=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, productName);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                Product product = new Product();
                product.setName(rs.getString("productName"));
                product.setType(rs.getString("productType"));
                product.setDescription(rs.getString("productDescription"));
                product.setQuantity(rs.getInt("productQuantity"));
                product.setPrice(rs.getDouble("productPrice"));
                HttpSession session = request.getSession();
                session.setAttribute("product", product);
                RequestDispatcher rd = request.getRequestDispatcher("product-details.jsp");
                rd.forward(request, response);
            }
            else {
                request.setAttribute("errorMessage", "No product of that name");
                RequestDispatcher rd = request.getRequestDispatcher("update-product.jsp");
                rd.forward(request, response);
            }



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

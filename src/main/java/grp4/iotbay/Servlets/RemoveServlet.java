<<<<<<< Updated upstream
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

@WebServlet ("/RemoveServlet")
public class RemoveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product = request.getParameter("productName");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
            );

            String sql = "DELETE FROM product WHERE productName=?";

            ps = con.prepareStatement(sql);
            ps.setString(1, product);
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected == 0) {
                request.setAttribute("errorMessage", "Error: No such product");
                RequestDispatcher rd = request.getRequestDispatcher("remove-product.jsp");
                rd.forward(request, response);
            }

            response.sendRedirect("remove-product.jsp");


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
=======
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

@WebServlet ("/RemoveServlet")
public class RemoveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product = request.getParameter("productName");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false",
                "u236601339_iotbayAdmin", "iotBaypassword1"
            );

            String sql = "DELETE FROM product WHERE productName=?";

            ps = con.prepareStatement(sql);
            ps.setString(1, product);
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected == 0) {
                request.setAttribute("errorMessage", "Error: No such product");
                RequestDispatcher rd = request.getRequestDispatcher("remove-product.jsp");
                rd.forward(request, response);
                return;
            }
            request.setAttribute("successMessage", "Product successfully removed");
            RequestDispatcher rd = request.getRequestDispatcher("remove-product.jsp");
            rd.forward(request, response);

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
>>>>>>> Stashed changes

package grp4.iotbay.Servlets;

import com.mysql.cj.Session;
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

@WebServlet("/FilterServlet")
public class FilterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");

            String sql = "SELECT * from u236601339_iotBay.product where productName=?";

            if(sql == null || sql.isEmpty()) {
                request.setAttribute("errorMessage", "No such product.");
            }

            ps = con.prepareStatement(sql);
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();

            if(!rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("product", null);
                RequestDispatcher rd = request.getRequestDispatcher("staff-home.jsp");
                rd.forward(request, response);
            }
            else{
                Product product = new Product();
                product.setName(rs.getString("productName"));
                product.setType(rs.getString("productType"));
                product.setPrice(rs.getDouble("productPrice"));
                product.setQuantity(rs.getInt("productQuantity"));
                HttpSession session = request.getSession();
                session.setAttribute("product", product);
                RequestDispatcher rd = request.getRequestDispatcher("staff-home.jsp");
                rd.forward(request, response);
            }
        }
        catch(SQLException | ClassNotFoundException e) {

        }
    }
}

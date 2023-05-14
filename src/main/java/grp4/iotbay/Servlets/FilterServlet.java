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
        HttpSession session = request.getSession();
        String productName = request.getParameter("productName");
        String referringFile = (String) session.getAttribute("referringFile");

       if(productName.isEmpty()) {
            session.setAttribute("product", null);
            RequestDispatcher rd = request.getRequestDispatcher(referringFile);
            rd.forward(request, response);
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");

            String sql = "SELECT * from u236601339_iotBay.product where productName=?";

            ps = con.prepareStatement(sql);
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();

            if(!rs.next()) {
                closeConnections(con, ps, rs);
                request.setAttribute("errorMessage", "Cannot find product.");
                session.setAttribute("product", null);
                RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                rd.forward(request, response);
            }
            else{
                Product product = new Product();
                product.setName(rs.getString("productName"));
                product.setType(rs.getString("productType"));
                product.setDescription(rs.getString("productDescription"));
                product.setPrice(rs.getDouble("productPrice"));
                product.setQuantity(rs.getInt("productQuantity"));
                closeConnections(con, ps, rs);
                session.setAttribute("product", product);
                RequestDispatcher rd = request.getRequestDispatcher(referringFile);
                rd.forward(request, response);
            }
        }
        catch(SQLException | ClassNotFoundException e) {

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

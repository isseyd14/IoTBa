package grp4.iotbay.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = request.getParameter("password");
        try{
            Connection con;

            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            System.out.println("Delete Connected");

            String sql = "delete from u236601339_iotBay.users where email=? and password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);
            int count = ps.executeUpdate();
            if (count == 0) {
                RequestDispatcher rd = request.getRequestDispatcher("delete_acc.jsp");
                rd.forward(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        }catch(SQLException | ClassNotFoundException e){
            System.out.println("Delete Error! - " + e.getMessage());
        }
    }
}

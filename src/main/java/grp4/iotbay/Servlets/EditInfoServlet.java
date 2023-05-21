package grp4.iotbay.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EditInfoServlet")
public class EditInfoServlet extends HttpServlet {
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String currentName = (String) session.getAttribute("name");
        String currentEmail = (String) session.getAttribute("email");
        String currentPwd = request.getParameter("current_pwd");

        String newPwd = request.getParameter("new_pwd");
        String newName = request.getParameter("new_name");
        String newEmail = request.getParameter("new_email");

        if (newPwd.equals("")) {
            newPwd = currentPwd;
        }
        if (newName.equals("")) {
            newName = currentName;
        }
        if (newEmail.equals("")) {
            newEmail = currentEmail;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try{

            Class.forName("com.mysql.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://auth-db624.hstgr.io/u236601339_iotBay?autoReconnect=true&useSSL=false", "u236601339_iotbayAdmin", "iotBaypassword1");
            System.out.println("Delete Connected");

            String sql = "update u236601339_iotBay.users set name=?, email=?, password=? where email=? and password=?";

            ps = con.prepareStatement(sql);

            ps.setString(1, newName);
            ps.setString(2, newEmail);
            ps.setString(3, newPwd);

            ps.setString(4, currentEmail);
            ps.setString(5, currentPwd);
            int count = ps.executeUpdate();
            if (count == 0) {
                RequestDispatcher rd = request.getRequestDispatcher("edit_info.jsp");
                rd.forward(request, response);
            } else {
              
                if (!newEmail.equals(currentEmail)) {
                    sql = "update u236601339_iotBay.access_logs set email=? where email=?";

                    ps = con.prepareStatement(sql);

                    ps.setString(1, newEmail);
                    ps.setString(2, currentEmail);
                    ps.executeUpdate();
                }
                session.setAttribute("name", newName);
                session.setAttribute("email", newEmail);
                response.sendRedirect("account.jsp");
            }
        }catch(SQLException | ClassNotFoundException e){
            System.out.println("Edit Error! - " + e.getMessage());
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
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
}

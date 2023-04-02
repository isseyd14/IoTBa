package grp6.iotbay;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/RegisterServerlet")
public class RegisterServerlet extends HttpServlet {
    @Override
    protected void doGet(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        
    }
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
       PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String name = request.getParameter("fname");
        String password = request.getParameter("password");
        
        try{
            Connection con = null;
            
            Class.forName("org.postgresql.Driver");
            
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/iotbay","postgres","yourpostgrespassword");
            System.out.println("Connected");
            
            String sql = "insert into iotbay.\"public\".users (name, email, password) values(?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
            
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request,response);
        }catch(ClassNotFoundException | SQLException e){
            System.out.println("Error! - " + e.getMessage());
        }
    }
}

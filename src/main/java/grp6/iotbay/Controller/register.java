package grp6.iotbay.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.* ;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class register extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
       
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
  
        String fullName = request.getParameter("fname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        try{
        
            Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/", "root", "kenson");
            System.out.println("Connected");
            
//            String sql = "insert into iotbay "
       
        } 
        
        catch(Exception e) {
            System.out.println("ERROR :: " +e.getMessage());
        }
        
        
    }

    
    
}
package grp6.iotbay;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(
            HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Validators validator = new Validators();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = null;

            final String userName = "u236601339_iotbayAdmin";
            final String passWord = "iotBaypassword1";
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://191.101.230.154:3306/", userName, passWord);
            System.out.println("Connected");
            ResultSet results = st.executeQuery("SELECT * FROM IOTBAY EMAIL = '" + email + "'");

            while (results.next()) {
                String Email = results.getString("Email");
                String Password = results.getString("Password");

                if (Email == username && Password == password) {
                    RequestDispatcher rd = request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                if (Email != username) {
                    session.setAttribute("InvalidLogin", "The credentials you have entered are invalid!");
                }
                if (Password != password) {
                    session.setAttribute("InvalidLogin", "The credentials you have entered are invalid!");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error! - " + e.getMessage());
        }
    }

}

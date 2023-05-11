package grp4.iotbay;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/LogoutServletMod")
public class LogoutServletMod extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // End session
        try {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}

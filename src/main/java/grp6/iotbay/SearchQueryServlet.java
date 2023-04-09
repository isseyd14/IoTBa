package grp6.iotbay;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/searchQuery")
public class SearchQueryServlet extends HttpServlet {
    @Override
    protected void doPost(
        HttpServletRequest request, HttpServletResponse response
    ) throws ServletException, IOException {
        // String query = request.getParameter("searchQuery");
        // connect to database and display results based on search query
    }
}

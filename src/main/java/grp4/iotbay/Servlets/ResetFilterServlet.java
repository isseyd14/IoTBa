package grp4.iotbay.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ResetFilterServlet")
public class ResetFilterServlet extends HttpServlet {

    String referringFile = "";
    @Override
    protected void doGet(
        HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        referringFile = (String) session.getAttribute("referringFile");
        session.setAttribute("products", null);
        RequestDispatcher rd = request.getRequestDispatcher(referringFile);
        rd.forward(request, response);
    }
}

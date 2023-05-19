package grp4.iotbay.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ResetPayFilter")
public class ResetPayFilter extends HttpServlet {

    String referringFile = "";
    @Override
    protected void doGet(
        HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        referringFile = (String) session.getAttribute("referringFile1");
        session.setAttribute("pay", null);
        RequestDispatcher rd = request.getRequestDispatcher("ViewPayList.jsp");
        rd.forward(request, response);
    }
}

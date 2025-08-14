package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users/delete")
public class AdminUserDeleteServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            new UserDAO().delete(id);
            resp.sendRedirect(req.getContextPath()+"/admin/users?ok=deleted");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

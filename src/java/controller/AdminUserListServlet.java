package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUserListServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User me = (User) req.getSession().getAttribute("user");
        if (me == null || !"Admin".equals(me.getRole())) {
            resp.sendRedirect(req.getContextPath()+"/jsp/shared/login.jsp?error=Please+login");
            return;
        }

        String q = req.getParameter("q");
        try {
            req.setAttribute("users", new UserDAO().list(q));
            req.getRequestDispatcher("/jsp/admin/users/list.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}

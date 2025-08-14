package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/users/create")
public class AdminUserCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Optional safety: ensure only Admin can open the form
        User me = (User) req.getSession().getAttribute("user");
        if (me == null || !"Admin".equals(me.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/shared/login.jsp?error=Please+login");
            return;
        }

        req.getRequestDispatcher("/jsp/admin/users/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Optional safety: ensure only Admin can submit
        User me = (User) req.getSession().getAttribute("user");
        if (me == null || !"Admin".equals(me.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            User u = new User();
            u.setUsername(req.getParameter("username"));
            u.setRole(req.getParameter("role"));
            u.setActive("on".equals(req.getParameter("active")));

            String rawPassword = req.getParameter("password"); // required for create
            new UserDAO().create(u, rawPassword);

            resp.sendRedirect(req.getContextPath() + "/admin/users?ok=created");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

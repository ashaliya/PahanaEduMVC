package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/users/edit")
public class AdminUserEditServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            User target = new UserDAO().find(id);
            req.setAttribute("target", target);
            req.getRequestDispatcher("/jsp/admin/users/form.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User u = new User();
            u.setId(Integer.parseInt(req.getParameter("id")));
            u.setUsername(req.getParameter("username"));
            u.setRole(req.getParameter("role"));
            u.setActive("on".equals(req.getParameter("active")));

            UserDAO dao = new UserDAO();
            dao.update(u);

            String newPass = req.getParameter("password");
            if (newPass != null && !newPass.isBlank()) {
                dao.updatePassword(u.getId(), newPass);
            }

            resp.sendRedirect(req.getContextPath()+"/admin/users?ok=updated");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

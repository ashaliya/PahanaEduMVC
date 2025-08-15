package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/customers/view")
public class CustomerViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin or Cashier
        model.User u = (model.User) req.getSession().getAttribute("user");
        if (u == null || !( "Admin".equals(u.getRole()) || "Cashier".equals(u.getRole()) )) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int account = Integer.parseInt(req.getParameter("account"));
            Customer c = new CustomerDAO().findByAccount(account);
            if (c == null) {
                resp.sendRedirect(req.getContextPath()+"/customers?error=Not+found");
                return;
            }
            req.setAttribute("c", c);
            req.getRequestDispatcher("/jsp/customers/view.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}

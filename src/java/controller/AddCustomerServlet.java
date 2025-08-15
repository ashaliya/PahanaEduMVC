package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/customers/create")
public class AddCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin only
        model.User u = (model.User) req.getSession().getAttribute("user");
        if (u == null || !"Admin".equals(u.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        req.getRequestDispatcher("/jsp/customers/form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin only
        model.User u = (model.User) req.getSession().getAttribute("user");
        if (u == null || !"Admin".equals(u.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int account = Integer.parseInt(req.getParameter("account_number"));
            String name = req.getParameter("name");
            String address = req.getParameter("address");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");

            if (name == null || name.isBlank()) {
                resp.sendRedirect(req.getContextPath()+"/customers/create?error=Name+is+required");
                return;
            }

            CustomerDAO dao = new CustomerDAO();
            if (dao.exists(account)) {
                resp.sendRedirect(req.getContextPath()+"/customers/create?error=Account+already+exists");
                return;
            }

            Customer c = new Customer();
            c.setAccountNumber(account);
            c.setName(name.trim());
            c.setAddress(address);
            c.setPhone(phone);
            c.setEmail(email);

            dao.create(c);
            resp.sendRedirect(req.getContextPath()+"/customers?ok=created");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

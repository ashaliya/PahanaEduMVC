package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/customers/edit")
public class EditCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Admin only
        model.User u = (model.User) req.getSession().getAttribute("user");
        if (u == null || !"Admin".equals(u.getRole())) {
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
            req.setAttribute("customer", c);
            req.getRequestDispatcher("/jsp/customers/form.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
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
                resp.sendRedirect(req.getContextPath()+"/customers/edit?account="+account+"&error=Name+is+required");
                return;
            }

            Customer c = new Customer();
            c.setAccountNumber(account);
            c.setName(name.trim());
            c.setAddress(address);
            c.setPhone(phone);
            c.setEmail(email);

            new CustomerDAO().update(c);
            resp.sendRedirect(req.getContextPath()+"/customers?ok=updated");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

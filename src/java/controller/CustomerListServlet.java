package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customers")
public class CustomerListServlet extends HttpServlet {
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
            String q = req.getParameter("q");
            List<Customer> customers = new CustomerDAO().search(q);
            req.setAttribute("q", q);
            req.setAttribute("customers", customers);
            req.getRequestDispatcher("/jsp/customers/list.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}

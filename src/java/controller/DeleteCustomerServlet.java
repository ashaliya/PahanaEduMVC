package controller;
import dao.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int acc = Integer.parseInt(req.getParameter("id"));
            new CustomerDAO().delete(acc);
            resp.sendRedirect(req.getContextPath()+"/customers/list");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

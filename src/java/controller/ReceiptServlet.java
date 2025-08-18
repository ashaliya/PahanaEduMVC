package controller;

import dao.BillDAO;
import model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cashier/receipt")
public class ReceiptServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Bill bill = new BillDAO().getBill(id);
            if (bill == null) {
                resp.sendRedirect(req.getContextPath()+"/cashier/bill-history?error=Bill+not+found");
                return;
            }
            req.setAttribute("bill", bill);
            req.getRequestDispatcher("/jsp/cashier/receipt.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}

package controller;

import dao.BillDAO;
import model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cashier/bill-history")
public class BillHistoryServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Bill> bills = new BillDAO().listBillsLast30();
            req.setAttribute("bills", bills);
            req.getRequestDispatcher("/jsp/cashier/history.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

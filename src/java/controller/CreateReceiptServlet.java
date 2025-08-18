package controller;

import dao.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cashier/create-receipt")
public class CreateReceiptServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/cashier/createReceipt.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String[] itemIdsStr = req.getParameterValues("itemId");
            String[] qtysStr    = req.getParameterValues("qty");
            if (itemIdsStr == null || qtysStr == null || itemIdsStr.length != qtysStr.length) {
                resp.sendRedirect(req.getContextPath()+"/cashier/create-receipt?error=Invalid+items");
                return;
            }
            int n = itemIdsStr.length, count = 0;
            int[] itemIds = new int[n], qtys = new int[n];

            for (int i = 0; i < n; i++) {
                if (itemIdsStr[i] == null || itemIdsStr[i].isBlank()) continue;
                int id  = Integer.parseInt(itemIdsStr[i]);
                int qty = Integer.parseInt(qtysStr[i]);
                if (qty <= 0) continue;
                itemIds[count] = id; qtys[count] = qty; count++;
            }
            if (count == 0) {
                resp.sendRedirect(req.getContextPath()+"/cashier/create-receipt?error=No+valid+lines");
                return;
            }
            int[] itemIds2 = new int[count], qtys2 = new int[count];
            System.arraycopy(itemIds, 0, itemIds2, 0, count);
            System.arraycopy(qtys, 0, qtys2, 0, count);

            Integer customerId = null; // (extend later)
            int billId = new BillDAO().createBill(customerId, itemIds2, qtys2);
            resp.sendRedirect(req.getContextPath()+"/cashier/receipt?id=" + billId);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath()+"/cashier/create-receipt?error=" + e.getMessage().replace(" ", "+"));
        }
    }
}

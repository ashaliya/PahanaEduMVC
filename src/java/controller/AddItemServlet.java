package controller;

import dao.ItemDAO;
import model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/stock/items/create")  // <--- this is the mapping!
public class AddItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/stock/itemForm.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String priceStr = req.getParameter("price");
            String qtyStr = req.getParameter("quantity");

            if (name == null || name.isBlank() || priceStr == null || qtyStr == null) {
                resp.sendRedirect(req.getContextPath()+"/stock/items/create?error=Missing+fields");
                return;
            }

            Item it = new Item();
            it.setName(name.trim());
            it.setPrice(new BigDecimal(priceStr));
            it.setQuantity(Integer.parseInt(qtyStr));

            new ItemDAO().create(it);
            resp.sendRedirect(req.getContextPath()+"/stock/items?ok=created");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath()+"/stock/items/create?error=" + e.getMessage().replace(" ", "+"));
        }
    }
}

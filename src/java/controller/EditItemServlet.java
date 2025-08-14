package controller;

import dao.ItemDAO;
import model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/stock/items/edit")
public class EditItemServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Item it = new ItemDAO().find(id);
            if (it == null) { resp.sendRedirect(req.getContextPath()+"/stock/items?error=Not+found"); return; }
            req.setAttribute("item", it);
            req.getRequestDispatcher("/jsp/stock/itemForm.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Item it = new Item();
            it.setItemId(Integer.parseInt(req.getParameter("id")));
            it.setName(req.getParameter("name"));
            it.setPrice(new java.math.BigDecimal(req.getParameter("price")));
            it.setQuantity(Integer.parseInt(req.getParameter("quantity")));
            new ItemDAO().update(it);
            resp.sendRedirect(req.getContextPath()+"/stock/items?ok=updated");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath()+"/stock/items?error=" + e.getMessage().replace(" ", "+"));
        }
    }
}

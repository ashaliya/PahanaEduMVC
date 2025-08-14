package controller;

import dao.ItemDAO;
import model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/stock/items")
public class ItemListServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String q    = req.getParameter("q");
        String sort = req.getParameter("sort");
        String dir  = req.getParameter("dir");
        int page = 1;
        try { page = Integer.parseInt(req.getParameter("page")); } catch(Exception ignored){}

        int offset = (page - 1) * PAGE_SIZE;

        try {
            ItemDAO dao = new ItemDAO();
            List<Item> items = dao.list(q, sort, dir, PAGE_SIZE, offset);
            int total = dao.count(q);
            int pages = (int) Math.ceil(total / (double) PAGE_SIZE);

            req.setAttribute("items", items);
            req.setAttribute("q", q);
            req.setAttribute("sort", sort == null ? "name" : sort);
            req.setAttribute("dir", dir == null ? "asc" : dir);
            req.setAttribute("page", page);
            req.setAttribute("pages", pages);
            req.setAttribute("total", total);

            req.getRequestDispatcher("/jsp/stock/items.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}

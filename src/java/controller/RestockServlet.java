package controller;

import dao.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/stock/items/restock")
public class RestockServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id    = Integer.parseInt(req.getParameter("id"));
            int delta = Integer.parseInt(req.getParameter("delta"));
            new ItemDAO().restock(id, delta);
            resp.sendRedirect(req.getContextPath()+"/stock/items?ok=restocked");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

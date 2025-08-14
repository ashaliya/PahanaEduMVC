package controller;

import dao.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/stock/items/delete")
public class DeleteItemServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            new ItemDAO().delete(id);
            resp.sendRedirect(req.getContextPath()+"/stock/items?ok=deleted");
        } catch (Exception e) { throw new ServletException(e); }
    }
}

package controller;

import dao.ReportDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/reports")
public class AdminReportsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User me = (User) req.getSession().getAttribute("user");
        if (me == null || !"Admin".equals(me.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/shared/login.jsp?error=Please+login");
            return;
        }

        try {
            ReportDAO r = new ReportDAO();
            req.setAttribute("top", r.topSellers30d());
            req.setAttribute("rev", r.revenueDaily30d());

            // Optional: set KPIs to also show on dashboard if you want to reuse
            req.setAttribute("userCount", r.totalUsers());
            req.setAttribute("itemCount", r.totalItems());
            req.setAttribute("customerCount", r.totalCustomers());
            req.setAttribute("rev30", r.revenueLast30dFormatted());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("top", null);
            req.setAttribute("rev", null);
        }

        req.getRequestDispatcher("/jsp/admin/reports.jsp").forward(req, resp);
    }
}

package controller;

import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Normalize path (strip context path)
        String ctx  = req.getContextPath();
        String path = req.getRequestURI().substring(ctx.length()); // e.g. "/admin/users"

        // -------- Public allowlist (no session required) --------
        boolean publicPath =
                path.equals("/") ||
                path.equals("/index.html") ||
                path.equals("/jsp/shared/login.jsp") ||
                path.equals("/LoginServlet") ||   // login handler
                path.equals("/logout") ||         // logout servlet
                path.startsWith("/css/") ||
                path.startsWith("/img/") ||
                path.startsWith("/js/") ||
                path.startsWith("/favicon") ||
                path.startsWith("/resources/");

        if (publicPath) {
            chain.doFilter(request, response);
            return;
        }

        // -------- Require login for everything else --------
        HttpSession session = req.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(ctx + "/jsp/shared/login.jsp?error=Please+login");
            return;
        }

        String role = user.getRole(); // "Admin", "Cashier", "StockKeeper"

        // -------- Admin can access everything --------
        if ("Admin".equals(role)) {
            chain.doFilter(request, response);
            return;
        }

        // -------- Area detection (for non-admin roles) --------
        boolean isAdminArea =
                path.startsWith("/admin/") || path.startsWith("/jsp/admin/");

        boolean isCashierArea =
                path.startsWith("/cashier/") || path.startsWith("/jsp/cashier/");

        boolean isStockArea =
                path.startsWith("/stock/") || path.startsWith("/jsp/stock/");

        // Customers — split into list/view (shared) vs create/edit (admin-only)
        boolean isCustomersListOrView =
                path.equals("/customers") ||
                path.startsWith("/customers/view") ||
                path.startsWith("/jsp/customers/list") ||
                path.startsWith("/jsp/customers/view");

        boolean isCustomersCreateOrEdit =
                path.startsWith("/customers/create") ||
                path.startsWith("/customers/edit") ||
                path.startsWith("/jsp/customers/form");

        // -------- Enforce rules for non-admins --------
        // Cashier:
        if ("Cashier".equals(role)) {
            // deny admin pages
            if (isAdminArea) { resp.sendError(HttpServletResponse.SC_FORBIDDEN); return; }
            // allow cashier pages
            if (isCashierArea) { chain.doFilter(request, response); return; }
            // allow customers list/view
            if (isCustomersListOrView) { chain.doFilter(request, response); return; }
            // deny customers create/edit
            if (isCustomersCreateOrEdit) { resp.sendError(HttpServletResponse.SC_FORBIDDEN); return; }
            // deny stock pages
            if (isStockArea) { resp.sendError(HttpServletResponse.SC_FORBIDDEN); return; }
            // everything else: allow (or tighten later if needed)
            chain.doFilter(request, response);
            return;
        }

        // StockKeeper:
        if ("StockKeeper".equals(role)) {
            // allow stock pages
            if (isStockArea) { chain.doFilter(request, response); return; }
            // deny admin & cashier pages
            if (isAdminArea || isCashierArea) { resp.sendError(HttpServletResponse.SC_FORBIDDEN); return; }
            // deny all customers pages (both list/view and create/edit)
            if (isCustomersListOrView || isCustomersCreateOrEdit) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN); return;
            }
            // everything else: allow (or tighten later if needed)
            chain.doFilter(request, response);
            return;
        }

        // Unknown role — safest to block
        resp.sendError(HttpServletResponse.SC_FORBIDDEN);
    }

    @Override
    public void destroy() {
        // no-op
    }
}

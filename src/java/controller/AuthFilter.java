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
        String path = req.getRequestURI().substring(ctx.length());

        //  Allow public pages and static assets (update if you add /js or /resources)
        boolean publicPath =
                path.equals("/") ||
                path.equals("/index.html") ||
                path.equals("/jsp/shared/login.jsp") ||
                path.equals("/LoginServlet") ||
                path.startsWith("/css/") ||
                path.startsWith("/img/") ||
                path.startsWith("/favicon") ||

                false;

        if (publicPath) {
            chain.doFilter(request, response);
            return;
        }

        //  Require login for everything else
        HttpSession session = req.getSession(false);
        User user = (session == null) ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(ctx + "/jsp/shared/login.jsp?error=Please+login");
            return;
        }

        //  Role-based authorization for JSP areas
        String role = user.getRole();
        if (path.startsWith("/jsp/admin/") && !"Admin".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        if (path.startsWith("/jsp/stock/") && !"StockKeeper".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        if (path.startsWith("/jsp/cashier/") && !"Cashier".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        //  OK, proceed
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // no-op
    }
}

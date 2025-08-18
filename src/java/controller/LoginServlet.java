package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;  
import java.io.IOException;

@WebServlet("/LoginServlet")                 
public class LoginServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String uname = req.getParameter("username");
    String pass  = req.getParameter("password");

    try {
      User u = new UserDAO().validate(uname, pass);
      if (u != null) {
        req.getSession(true).setAttribute("user", u);
        switch (u.getRole()) {
          case "Admin":       resp.sendRedirect(req.getContextPath()+"/jsp/admin/dashboard.jsp"); break;
          case "Cashier":     resp.sendRedirect(req.getContextPath()+"/jsp/cashier/dashboard.jsp"); break;
          case "StockKeeper": resp.sendRedirect(req.getContextPath()+"/jsp/stock/dashboard.jsp"); break;
          default: resp.sendRedirect(req.getContextPath()+"/jsp/shared/login.jsp?error=Unknown+role");
        }
      } else {
        resp.sendRedirect(req.getContextPath()+"/jsp/shared/login.jsp?error=Invalid+credentials");
      }
    } catch (Exception e) { throw new ServletException(e); }
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    resp.sendRedirect(req.getContextPath()+"/jsp/shared/login.jsp");
  }
}

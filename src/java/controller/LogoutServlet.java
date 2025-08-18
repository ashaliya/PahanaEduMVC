package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    // 1) Invalidate session if present
    HttpSession session = req.getSession(false);
    if (session != null) {
      session.invalidate();
    }

    // 2) Proactively expire JSESSIONID cookie (defense in depth)
    Cookie kill = new Cookie("JSESSIONID", "");
    kill.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
    kill.setMaxAge(0);
    // Optional: if your app runs on HTTPS, also set:
    // kill.setSecure(true);
    kill.setHttpOnly(true);
    resp.addCookie(kill);

    // 3) Prevent cached pages after logout (Back button)
    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP/1.1
    resp.setHeader("Pragma", "no-cache");                                    // HTTP/1.0
    resp.setDateHeader("Expires", 0);                                        // Proxies

    // 4) Redirect to login with a friendly message
    String msg = URLEncoder.encode("Logged out", StandardCharsets.UTF_8.name());
    resp.sendRedirect(req.getContextPath() + "/jsp/shared/login.jsp?msg=" + msg);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    doGet(req, resp); // support POST too
  }
}

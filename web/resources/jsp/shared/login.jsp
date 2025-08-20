<%@ page contentType="text/html;charset=UTF-8" %> 
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Login • PahanaEdu</title>

  <!-- Bootstrap + Icons + Google Font -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  <link rel="stylesheet" href="<%=ctx%>/css/custom.css">
  <link rel="icon" type="image/png" href="<%=ctx%>/img/logo.jpg">
</head>
<body class="bg-hero" style="background-image:url('<%=ctx%>/img/books-hero.jpg')">
  <div class="overlay"></div>

  <nav class="navbar navbar-expand-lg navbar-dark navbar-gradient shadow-sm">
    <div class="container">
      <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
        <img src="<%=ctx%>/img/logo.jpg" alt="logo" height="32" class="me-2"> PahanaEdu
        
      </a>
    </div>
  </nav>

  <section class="d-flex align-items-center justify-content-center" style="min-height:calc(100vh - 64px);">
    <div class="card glass shadow-lg" style="max-width:380px;width:100%;">
      <div class="card-body p-4">
        <div class="text-center mb-3">
          <img src="<%=ctx%>/img/logo.jpg" height="48" alt="Logo">
          <h1 class="h4 fw-bold mt-2">Welcome to Pahana Edu</h1>
          <p class="text-muted small mb-0">Online Billing System</p>
        </div>

        <!-- ✅ Logged out success message -->
        <% if(request.getParameter("msg") != null){ %>
          <div id="logoutMsg" class="alert alert-success py-2 small mb-3"><%=request.getParameter("msg")%></div>
        <% } %>

        <!-- ❌ Error message -->
        <% if(request.getParameter("error") != null){ %>
          <div class="alert alert-danger py-2 small mb-3"><%=request.getParameter("error")%></div>
        <% } %>

        <form action="<%=ctx%>/LoginServlet" method="post" novalidate>
          <div class="mb-3">
            <label class="form-label">Username</label>
            <input name="username" class="form-control form-control-lg" required>
          </div>
          <div class="mb-2">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control form-control-lg" required>
          </div>

          <button class="btn btn-primary w-100 btn-lg">
            <i class="bi bi-box-arrow-in-right me-1"></i> Login
          </button>
        </form>

        <div class="text-center small text-muted mt-3">
          Need help? <a class="link-secondary" href="<%=ctx%>/jsp/help.jsp">Read the guide</a>
        </div>
      </div>
    </div>
  </section>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Auto-hide success message after 3 seconds
    document.addEventListener("DOMContentLoaded", function(){
      const msg = document.getElementById("logoutMsg");
      if(msg){
        setTimeout(() => {
          msg.style.transition = "opacity 0.5s ease";
          msg.style.opacity = "0";
          setTimeout(() => msg.remove(), 500);
        }, 3000);
      }
    });
  </script>
</body>
</html>

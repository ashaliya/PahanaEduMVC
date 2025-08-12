<%@ page contentType="text/html;charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Login • PahanaEdu</title>

  <!-- Bootstrap CSS (for modern styles) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Optional: Icons + Google Font -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">

  <!-- Your custom CSS should load AFTER Bootstrap so it can override -->
  <link rel="stylesheet" href="<%=ctx%>/css/custom.css">
</head>
<body class="bg-hero d-flex align-items-center" style="min-height:100vh; background-image:url('<%=ctx%>/img/books-hero.jpg')">

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-11 col-sm-9 col-md-7 col-lg-5">
        <div class="card shadow-lg glass">
          <div class="card-body p-4">
            <div class="text-center mb-3">
              <img src="<%=ctx%>/img/logo.png" height="48" alt="Logo">
              <h1 class="h4 fw-bold mt-2">Welcome to PahanaEdu</h1>
              <p class="text-muted small mb-0">Bookshop Management System</p>
            </div>

            <form action="<%=ctx%>/LoginServlet" method="post" novalidate>
              <div class="mb-3">
                <label class="form-label">Username</label>
                <input name="username" class="form-control form-control-lg" required>
              </div>
              <div class="mb-2">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control form-control-lg" required>
              </div>

              <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger py-2 small mb-3"><%= request.getParameter("error") %></div>
              <% } %>

              <button type="submit" class="btn btn-primary w-100 btn-lg">
                <i class="bi bi-box-arrow-in-right me-1"></i> Sign in
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

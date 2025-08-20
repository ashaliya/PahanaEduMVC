<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<%
  String ctx = request.getContextPath();
  Object u = session.getAttribute("user");
  // Use the exact role string you use elsewhere: "StockKeeper"
  if (u == null || !"StockKeeper".equals(((model.User)u).getRole())) {
      response.sendRedirect(ctx + "/jsp/shared/login.jsp?error=Please+login");
      return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Stock Dashboard • PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    /* Make the hero fill the viewport (minus navbar) and center content */
    .hero-center {
      background-size: cover;
      background-position: center;
      min-height: calc(100vh - 64px); /* adjust if your navbar is taller */
      display: flex;
      align-items: center; /* vertical center */
    }
    @media (max-width: 991px){
      .hero-center { min-height: calc(100vh - 56px); }
    }
    .action-card { text-decoration: none; transition: transform .2s ease; }
    .action-card:hover { transform: translateY(-3px); }
    .action-icon { font-size: 2rem; }
    .text-shadow { text-shadow: 0 2px 6px rgba(0,0,0,.35); }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.jpg" height="28" class="me-2" alt="logo"> Stock Keeper
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout">
  <i class="bi bi-box-arrow-right me-1"></i> Logout
</a>

  </div>
</nav>

<header class="hero-center" style="background-image:url('<%=ctx%>/img/stock.jpg')">
  <div class="container">
    <div class="text-center text-white mb-4">
      <h1 class="fw-bold text-shadow mb-1">Stock Dashboard</h1>
      <p class="lead text-white-50 text-shadow mb-0">Manage inventory & add new items</p>
    </div>

    <!-- Actions centered INSIDE the hero -->
    <div class="row g-4 justify-content-center">
      <!-- Item List -->
      <div class="col-md-5 col-lg-4">
        <a class="card action-card shadow-sm" href="<%=ctx%>/stock/items">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-box-seam action-icon text-primary"></i>
            <div class="ms-3">
              <h5 class="mb-1">Item List</h5>
              <p class="text-muted mb-0 small">Search, sort & manage inventory</p>
            </div>
          </div>
        </a>
      </div>
      <!-- Add New Item -->
      <div class="col-md-5 col-lg-4">
        <a class="card action-card shadow-sm" href="<%=ctx%>/stock/items/create">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-plus-square action-icon text-success"></i>
            <div class="ms-3">
              <h5 class="mb-1">Add New Item</h5>
              <p class="text-muted mb-0 small">Quickly add stock</p>
            </div>
          </div>
        </a>
      </div>
    </div>

  </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

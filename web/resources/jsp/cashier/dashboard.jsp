<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<% String ctx = request.getContextPath(); %>
<% Object u = session.getAttribute("user");
   if (u == null || !"Cashier".equals(((model.User)u).getRole())) {
       response.sendRedirect(ctx + "/jsp/shared/login.jsp?error=Please+login");
       return;
   }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Cashier Dashboard • PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=ctx%>/css/custom.css">
  <style>
    /* Make the hero itself center everything */
    .hero-center {
      background-size: cover; background-position: center;
      min-height: calc(100vh - 64px); /* viewport minus navbar ~64px */
      display: flex; align-items: center;
    }
    .action-card { text-decoration: none; transition: transform .2s ease; }
    .action-card:hover { transform: translateY(-3px); }
    .action-icon { font-size: 2rem; }
    @media (max-width: 991px){
      .hero-center { min-height: calc(100vh - 56px); } /* smaller nav on mobile */
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.jpg" height="28" class="me-2" alt="logo"> Cashier
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout">
      <i class="bi bi-box-arrow-right me-1"></i> Logout
    </a>
  </div>
</nav>

<header class="hero-center" style="background-image:url('<%=ctx%>/img/cashier.jpg')">
  <div class="container">
    <div class="text-center text-white mb-4">
      <h1 class="fw-bold text-shadow mb-1">Cashier</h1>
      <p class="lead text-white-50 text-shadow mb-0">Create bills & view history</p>
    </div>

    <!-- Actions centered INSIDE the hero -->
    <div class="row g-4 justify-content-center">
      <div class="col-md-5 col-lg-4">
        <a class="card action-card shadow-sm" href="<%=ctx%>/cashier/create-receipt">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-receipt action-icon text-success"></i>
            <div class="ms-3">
              <h5 class="mb-1">Create Receipt</h5>
              <p class="text-muted mb-0 small">Bill a customer for items</p>
            </div>
          </div>
        </a>
      </div>
      <div class="col-md-5 col-lg-4">
        <a class="card action-card shadow-sm" href="<%=ctx%>/cashier/bill-history">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-clock-history action-icon text-primary"></i>
            <div class="ms-3">
              <h5 class="mb-1">Bill History</h5>
              <p class="text-muted mb-0 small">See recent bills and totals</p>
            </div>
          </div>
        </a>
      </div>
      <!-- ✅ New: Manage Customers -->
      <div class="col-md-5 col-lg-4">
        <a class="card action-card shadow-sm" href="<%=ctx%>/customers">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-person-lines-fill action-icon text-info"></i>
            <div class="ms-3">
              <h5 class="mb-1">View Customers</h5>
              <p class="text-muted mb-0 small">View customer details</p>
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

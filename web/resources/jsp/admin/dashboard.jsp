<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<% String ctx = request.getContextPath(); %>
<% Object u = session.getAttribute("user");
   if (u == null || !"Admin".equals(((model.User)u).getRole())) {
       response.sendRedirect(ctx + "/jsp/shared/login.jsp?error=Please+login");
       return;
   }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Admin Dashboard • PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="<%=ctx%>/css/custom.css">
  <style>
    .hero-center {
      background-size: cover; background-position: center;
      min-height: calc(100vh - 64px); /* viewport minus navbar */
      display: flex; align-items: center;
    }
    .action-card { text-decoration: none; transition: transform .2s ease; }
    .action-card:hover { transform: translateY(-3px); }
    .action-icon { font-size: 2rem; }
    .kpi-icon {
      width: 48px; height: 48px; display: flex; align-items: center; justify-content: center;
      font-size: 1.5rem; border-radius: .5rem;
    }
    .text-shadow { text-shadow: 0 2px 6px rgba(0,0,0,.35); }
    @media (max-width: 991px){
      .hero-center { min-height: calc(100vh - 56px); }
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.jpg" height="28" class="me-2" alt="logo"> Admin
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout">
      <i class="bi bi-box-arrow-right me-1"></i> Logout
    </a>
  </div>
</nav>

<!-- HERO with centered actions -->
<header class="hero-center" style="background-image:url('<%=ctx%>/img/shelves.jpg')">
  <div class="container">
    <div class="text-center text-white mb-4">
      <h1 class="fw-bold text-shadow mb-1">Admin Dashboard</h1>
      <p class="lead text-white-50 text-shadow mb-0">Quick actions and today’s overview</p>
    </div>

    <!-- Top row: primary actions -->
    <div class="row g-4 justify-content-center mb-4">
      <div class="col-md-4 col-lg-3">
        <a class="card action-card shadow-sm" href="<%=ctx%>/admin/users">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-people-fill action-icon text-primary"></i>
            <div class="ms-3">
              <h5 class="mb-1">Manage Users</h5>
              <p class="text-muted mb-0 small">Create, edit, delete accounts</p>
            </div>
          </div>
        </a>
      </div>
      <div class="col-md-4 col-lg-3">
        <a class="card action-card shadow-sm" href="<%=ctx%>/admin/users">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-person-gear action-icon text-warning"></i>
            <div class="ms-3">
              <h5 class="mb-1">Assign Roles</h5>
              <p class="text-muted mb-0 small">Set Admin/Cashier/Stock Keeper</p>
            </div>
          </div>
        </a>
      </div>
      <div class="col-md-4 col-lg-3">
        <a class="card action-card shadow-sm" href="<%=ctx%>/admin/reports">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-bar-chart-line-fill action-icon text-success"></i>
            <div class="ms-3">
              <h5 class="mb-1">View Reports</h5>
              <p class="text-muted mb-0 small">Sales & inventory insights</p>
            </div>
          </div>
        </a>
      </div>
      <!-- ✅ New: Manage Customers (links to /customers) -->
      <div class="col-md-4 col-lg-3">
        <a class="card action-card shadow-sm" href="<%=ctx%>/customers">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-person-lines-fill action-icon text-info"></i>
            <div class="ms-3">
              <h5 class="mb-1">Manage Customers</h5>
              <p class="text-muted mb-0 small">Add, edit & view accounts</p>
            </div>
          </div>
        </a>
      </div>
    </div>

    <!-- Second row: compact KPIs -->
    <div class="row g-3 justify-content-center">
      <div class="col-sm-6 col-lg-3">
        <div class="card shadow-sm h-100">
          <div class="card-body d-flex align-items-center">
            <div class="kpi-icon bg-primary-subtle text-primary"><i class="bi bi-people"></i></div>
            <div class="ms-3">
              <h6 class="text-muted mb-0">Customers Report</h6>
              <div class="h4 mb-1"><%= request.getAttribute("customerCount")==null?"-":request.getAttribute("customerCount") %></div>
              <a class="small text-decoration-none" href="<%=ctx%>/customers">Open customer list →</a>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-lg-3">
        <div class="card shadow-sm h-100">
          <div class="card-body d-flex align-items-center">
            <div class="kpi-icon bg-warning-subtle text-warning"><i class="bi bi-box-seam"></i></div>
            <div class="ms-3">
              <h6 class="text-muted mb-0">Items in stock</h6>
              <div class="h4 mb-1"><%= request.getAttribute("itemCount")==null?"-":request.getAttribute("itemCount") %></div>
              <a class="small text-decoration-none" href="<%=ctx%>/stock/items">Manage items →</a>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-lg-3">
        <div class="card shadow-sm h-100">
          <div class="card-body d-flex align-items-center">
            <div class="kpi-icon bg-success-subtle text-success"><i class="bi bi-graph-up-arrow"></i></div>
            <div class="ms-3">
              <h6 class="text-muted mb-0">Revenue (30d)</h6>
              <div class="h4 mb-1">Rs <%= request.getAttribute("rev30")==null?"—":request.getAttribute("rev30") %></div>
              <a class="small text-decoration-none" href="<%=ctx%>/admin/reports">View reports →</a>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-lg-3">
        <div class="card shadow-sm h-100">
          <div class="card-body d-flex align-items-center">
            <div class="kpi-icon bg-info-subtle text-info"><i class="bi bi-person-badge"></i></div>
            <div class="ms-3">
              <h6 class="text-muted mb-0">User Accounts</h6>
              <div class="h4 mb-1"><%= request.getAttribute("userCount")==null?"-":request.getAttribute("userCount") %></div>
              <a class="small text-decoration-none" href="<%=ctx%>/admin/users">Manage users →</a>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

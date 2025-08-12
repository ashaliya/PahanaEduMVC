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
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.png" height="28" class="me-2"> Admin
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout.jsp"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
  </div>
</nav>

<header class="py-5 bg-hero" style="background-image:url('<%=ctx%>/img/shelves.jpg')">
  <div class="container">
    <h1 class="display-6 fw-bold text-white text-shadow mb-1">Admin Dashboard</h1>
    <p class="lead text-white-50 text-shadow">Manage customers, users, and reports</p>
  </div>
</header>

<main class="container my-4">
  <div class="row g-4">
    <div class="col-md-4">
      <div class="card kpi-card shadow-sm">
        <div class="card-body d-flex align-items-center">
          <div class="kpi-icon bg-primary-subtle text-primary"><i class="bi bi-people"></i></div>
          <div class="ms-3">
            <h6 class="text-muted mb-0">Customers</h6>
            <div class="h4 mb-0"><%= request.getAttribute("customerCount")==null?"-":request.getAttribute("customerCount") %></div>
          </div>
        </div>
        <div class="card-footer bg-transparent">
          <a class="small" href="<%=ctx%>/customers/list">Open customer list →</a>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card kpi-card shadow-sm">
        <div class="card-body d-flex align-items-center">
          <div class="kpi-icon bg-warning-subtle text-warning"><i class="bi bi-box-seam"></i></div>
          <div class="ms-3">
            <h6 class="text-muted mb-0">Items in stock</h6>
            <div class="h4 mb-0"><%= request.getAttribute("itemCount")==null?"-":request.getAttribute("itemCount") %></div>
          </div>
        </div>
        <div class="card-footer bg-transparent">
          <a class="small" href="<%=ctx%>/items/list">Manage items →</a>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card kpi-card shadow-sm">
        <div class="card-body d-flex align-items-center">
          <div class="kpi-icon bg-success-subtle text-success"><i class="bi bi-graph-up-arrow"></i></div>
          <div class="ms-3">
            <h6 class="text-muted mb-0">Revenue (30d)</h6>
            <div class="h4 mb-0">Rs <%= request.getAttribute("rev30")==null?"—":request.getAttribute("rev30") %></div>
          </div>
        </div>
        <div class="card-footer bg-transparent">
          <a class="small" href="<%=ctx%>/jsp/reports/overview.jsp">View reports →</a>
        </div>
      </div>
    </div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

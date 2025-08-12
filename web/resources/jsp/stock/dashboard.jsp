<%@ page contentType="text/html;charset=UTF-8" session="true" %>
<% String ctx = request.getContextPath(); %>
<% Object u = session.getAttribute("user");
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
  <link rel="stylesheet" href="<%=ctx%>/css/custom.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.png" height="28" class="me-2"> Stock
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout.jsp"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
  </div>
</nav>

<header class="py-5 bg-hero" style="background-image:url('<%=ctx%>/img/stock.jpg')">
  <div class="container">
    <h1 class="display-6 fw-bold text-white text-shadow mb-1">Stock Keeper</h1>
    <p class="lead text-white-50 text-shadow">Manage and track inventory</p>
  </div>
</header>

<main class="container my-4">
  <div class="row g-4">
    <div class="col-md-6">
      <a class="card action-card shadow-sm" href="<%=ctx%>/items/list">
        <div class="card-body d-flex align-items-center">
          <i class="bi bi-list-ul action-icon text-primary"></i>
          <div class="ms-3">
            <h5 class="mb-1">Item List</h5>
            <p class="text-muted mb-0 small">Search, sort and manage inventory</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-6">
      <a class="card action-card shadow-sm" href="<%=ctx%>/jsp/stock/addItem.jsp">
        <div class="card-body d-flex align-items-center">
          <i class="bi bi-plus-circle action-icon text-success"></i>
          <div class="ms-3">
            <h5 class="mb-1">Add New Item</h5>
            <p class="text-muted mb-0 small">Quickly add stock</p>
          </div>
        </div>
      </a>
    </div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

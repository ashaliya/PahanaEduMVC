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
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background:linear-gradient(90deg,#5b7fff,#7bdcff)">
  <div class="container">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
      <img src="<%=ctx%>/img/logo.png" height="28" class="me-2"> Cashier
    </a>
    <a class="btn btn-light btn-sm ms-auto" href="<%=ctx%>/logout.jsp"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
  </div>
</nav>

<header class="py-5 bg-hero" style="background-image:url('<%=ctx%>/img/cashier.jpg')">
  <div class="container">
    <h1 class="display-6 fw-bold text-white text-shadow mb-1">Cashier</h1>
    <p class="lead text-white-50 text-shadow">Create bills & view history</p>
  </div>
</header>

<main class="container my-4">
  <div class="row g-4">
    <div class="col-md-6">
      <a class="card action-card shadow-sm" href="<%=ctx%>/jsp/cashier/createReceipt.jsp">
        <div class="card-body d-flex align-items-center">
          <i class="bi bi-receipt action-icon text-success"></i>
          <div class="ms-3">
            <h5 class="mb-1">Create Receipt</h5>
            <p class="text-muted mb-0 small">Bill a customer for items</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-6">
      <a class="card action-card shadow-sm" href="<%=ctx%>/cashier/history">
        <div class="card-body d-flex align-items-center">
          <i class="bi bi-clock-history action-icon text-primary"></i>
          <div class="ms-3">
            <h5 class="mb-1">Bill History</h5>
            <p class="text-muted mb-0 small">See recent bills and totals</p>
          </div>
        </div>
      </a>
    </div>
  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

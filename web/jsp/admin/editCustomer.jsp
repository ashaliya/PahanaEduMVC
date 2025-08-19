<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer" %>
<%
  Customer c = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Customer</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Edit Customer</h2>
  <form action="<%=request.getContextPath()%>/customers/edit" method="post" class="row g-3">
    <div class="col-md-4">
      <label class="form-label">Account Number</label>
      <input type="number" class="form-control" name="account_number" value="<%=c.getAccountNumber()%>" readonly>
    </div>
    <div class="col-md-8">
      <label class="form-label">Name</label>
      <input class="form-control" name="name" value="<%=c.getName()%>" required>
    </div>
    <div class="col-12">
      <label class="form-label">Address</label>
      <input class="form-control" name="address" value="<%=c.getAddress()%>" required>
    </div>
    <div class="col-md-6">
      <label class="form-label">Phone</label>
      <input class="form-control" name="phone" value="<%=c.getPhone()%>" required>
    </div>
    <div class="col-md-6">
      <label class="form-label">Units Consumed</label>
      <input type="number" class="form-control" name="units_consumed" value="<%=c.getUnitsConsumed()%>" required>
    </div>
    <div class="col-12">
      <button class="btn btn-primary">Update</button>
      <a class="btn btn-secondary" href="<%=request.getContextPath()%>/customers/list">Cancel</a>
    </div>
  </form>
</body>
</html>

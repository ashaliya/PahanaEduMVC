<!DOCTYPE html>
<html>
<head>
  <title>Create Receipt</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Create Receipt (single item)</h2>
  <form action="<%=request.getContextPath()%>/cashier/create" method="post" class="row g-3 col-md-6">
    <div class="col-12">
      <label class="form-label">Item ID</label>
      <input type="number" name="item_id" class="form-control" required>
    </div>
    <div class="col-12">
      <label class="form-label">Quantity</label>
      <input type="number" name="qty" class="form-control" required>
    </div>
    <div class="col-12">
      <button class="btn btn-primary">Create</button>
      <a class="btn btn-secondary" href="<%=request.getContextPath()%>/jsp/cashier/dashboard.jsp">Back</a>
    </div>
  </form>
</body>
</html>

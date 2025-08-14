<!DOCTYPE html>
<html>
<head>
  <title>Add Item</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Add Item</h2>
  <form action="<%=request.getContextPath()%>/AddItemServlet" method="post" class="row g-3">
    <div class="col-md-6">
      <label class="form-label">Name</label>
      <input class="form-control" name="name" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Price</label>
      <input type="number" step="0.01" class="form-control" name="price" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Quantity</label>
      <input type="number" class="form-control" name="quantity" required>
    </div>
    <div class="col-12">
      <button class="btn btn-primary">Save</button>
      <a class="btn btn-secondary" href="<%=request.getContextPath()%>/items/list">Cancel</a>
    </div>
  </form>
</body>
</html>

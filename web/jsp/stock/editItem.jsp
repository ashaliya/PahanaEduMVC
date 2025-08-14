<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Item" %>
<%
  Item it = (Item) request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Item</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Edit Item</h2>
  <form action="<%=request.getContextPath()%>/items/edit" method="post" class="row g-3">
    <input type="hidden" name="item_id" value="<%=it.getItemId()%>" />
    <div class="col-md-6">
      <label class="form-label">Name</label>
      <input class="form-control" name="name" value="<%=it.getName()%>" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Price</label>
      <input type="number" step="0.01" class="form-control" name="price" value="<%=it.getPrice()%>" required>
    </div>
    <div class="col-md-3">
      <label class="form-label">Quantity</label>
      <input type="number" class="form-control" name="quantity" value="<%=it.getQuantity()%>" required>
    </div>
    <div class="col-12">
      <button class="btn btn-primary">Update</button>
      <a class="btn btn-secondary" href="<%=request.getContextPath()%>/items/list">Cancel</a>
    </div>
  </form>
</body>
</html>

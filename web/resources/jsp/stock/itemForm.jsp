<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Add New Item</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:700px;">
  <h3>Add New Item</h3>

  <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <form method="post" action="<%=ctx%>/stock/items/create">
    <div class="mb-3">
      <label class="form-label">Name</label>
      <input class="form-control" name="name" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Price (Rs)</label>
      <input class="form-control" name="price" type="number" step="0.01" min="0" required>
    </div>

    <div class="mb-3">
      <label class="form-label">Quantity</label>
      <input class="form-control" name="quantity" type="number" min="0" required>
    </div>

    <button class="btn btn-primary">Create Item</button>
  </form>
</body>
</html>

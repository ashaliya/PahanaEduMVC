<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<% String ctx = request.getContextPath(); User t = (User)request.getAttribute("target"); boolean editing = (t!=null); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><%=editing?"Edit":"Create"%> User</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:720px;">
  <h3 class="mb-3"><%=editing?"Edit":"Create"%> User</h3>

  <form method="post" action="<%=ctx%><%=editing?"/admin/users/edit":"/admin/users/create"%>">
    <% if (editing) { %><input type="hidden" name="id" value="<%=t.getId()%>"><% } %>

    <div class="mb-3">
      <label class="form-label">Username</label>
      <input name="username" class="form-control" required value="<%=editing?t.getUsername():""%>">
    </div>

    <div class="mb-3">
      <label class="form-label"><%=editing?"New Password (optional)":"Password"%></label>
      <input type="password" name="password" class="form-control" <%=editing?"":"required"%>>
    </div>

    <div class="mb-3">
      <label class="form-label">Role</label>
      <select class="form-select" name="role" required>
        <option value="Admin"       <%=editing && "Admin".equals(t.getRole())?"selected":""%>>Admin</option>
        <option value="Cashier"     <%=editing && "Cashier".equals(t.getRole())?"selected":""%>>Cashier</option>
        <option value="StockKeeper" <%=editing && "StockKeeper".equals(t.getRole())?"selected":""%>>Stock Keeper</option>
      </select>
    </div>

    <div class="form-check mb-3">
      <input class="form-check-input" type="checkbox" id="active" name="active"
             <%=(!editing || t.isActive())?"checked":""%>>
      <label class="form-check-label" for="active">Active</label>
    </div>

    <div class="d-flex gap-2">
      <button class="btn btn-primary"><%=editing?"Save Changes":"Create User"%></button>
      <a class="btn btn-outline-secondary" href="<%=ctx%>/admin/users">Cancel</a>
    </div>
  </form>
</body>
</html>

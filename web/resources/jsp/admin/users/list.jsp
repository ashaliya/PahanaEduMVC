<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.User" %>
<% String ctx = request.getContextPath(); List<User> users = (List<User>)request.getAttribute("users"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Manage Users</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Manage Users</h3>
    <a class="btn btn-primary" href="<%=ctx%>/admin/users/create">+ New User</a>
  </div>

  <table class="table table-hover align-middle">
    <thead><tr><th>ID</th><th>Username</th><th>Role</th><th>Status</th><th class="text-end">Actions</th></tr></thead>
    <tbody>
    <% if (users!=null) for (User u : users) { %>
      <tr>
        <td><%=u.getId()%></td>
        <td><%=u.getUsername()%></td>
        <td><%=u.getRole()%></td>
        <td><%= u.isActive() ? "Active" : "Inactive" %></td>
        <td class="text-end">
          <a class="btn btn-sm btn-outline-primary" href="<%=ctx%>/admin/users/edit?id=<%=u.getId()%>">Edit</a>
          <form action="<%=ctx%>/admin/users/delete" method="post" class="d-inline"
                onsubmit="return confirm('Delete this user?');">
            <input type="hidden" name="id" value="<%=u.getId()%>">
            <button class="btn btn-sm btn-outline-danger">Delete</button>
          </form>
        </td>
      </tr>
    <% } %>
    </tbody>
  </table>
</body>
</html>

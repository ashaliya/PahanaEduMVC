<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Customer" %>
<%
  String ctx = request.getContextPath();
  List<Customer> customers = (List<Customer>) request.getAttribute("customers");
  String q = (String) request.getAttribute("q");

  // who is logged in?
  model.User u = (model.User) session.getAttribute("user");
  boolean isAdmin = (u != null && "Admin".equals(u.getRole()));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Customers</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:1000px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Customers</h3>
    <% if (isAdmin) { %>
      <a class="btn btn-success" href="<%=ctx%>/customers/create">+ New Customer</a>
    <% } %>
  </div>

  <% if (request.getParameter("ok") != null) { %>
    <div class="alert alert-success py-2">Done: <%=request.getParameter("ok")%></div>
  <% } %>
  <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger py-2"><%=request.getParameter("error") %></div>
  <% } %>

  <form class="row g-2 mb-3" method="get" action="<%=ctx%>/customers">
    <div class="col-md-6">
      <input class="form-control" name="q" value="<%= q==null?"":q %>" placeholder="Search by name or phone">
    </div>
    <div class="col-md-2">
      <button class="btn btn-primary w-100">Search</button>
    </div>
  </form>

  <div class="table-responsive">
    <table class="table table-hover align-middle">
      <thead>
        <tr>
          <th>Account #</th><th>Name</th><th>Phone</th><th>Email</th><th>Actions</th>
        </tr>
      </thead>
      <tbody>
      <% if (customers != null && !customers.isEmpty()) {
           for (Customer c : customers) { %>
        <tr>
          <td><%= c.getAccountNumber() %></td>
          <td><%= c.getName() %></td>
          <td><%= c.getPhone() %></td>
          <td><%= (c.getEmail()==null || c.getEmail().isBlank()) ? "—" : c.getEmail() %></td>
          <td>
            <!-- View: allowed for Admin and Cashier -->
            <a class="btn btn-sm btn-outline-primary"
               href="<%=ctx%>/customers/view?account=<%=c.getAccountNumber()%>">View</a>
            <!-- Edit: only Admin -->
            <% if (isAdmin) { %>
              <a class="btn btn-sm btn-outline-secondary"
                 href="<%=ctx%>/customers/edit?account=<%=c.getAccountNumber()%>">Edit</a>
            <% } %>
          </td>
        </tr>
      <% } } else { %>
        <tr><td colspan="5" class="text-center text-muted">No customers found</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
</body>
</html>

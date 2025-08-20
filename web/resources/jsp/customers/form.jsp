<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<%
  String ctx = request.getContextPath();
  Customer customer = (Customer) request.getAttribute("customer"); // null if create
  boolean edit = (customer != null);
  String accValue = edit ? String.valueOf(customer.getAccountNumber()) : "";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><%= edit ? "Edit" : "Add" %> Customer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:700px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0"><%= edit ? "Edit" : "Add New" %> Customer</h3>
    <a class="btn btn-outline-secondary" href="<%=ctx%>/customers">← Back</a>
  </div>

  <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger py-2"><%= request.getParameter("error") %></div>
  <% } %>

  <form method="post" action="<%=ctx%><%= edit ? "/customers/edit" : "/customers/create" %>">
    <div class="mb-3">
      <label class="form-label">Account Number</label>
      <input class="form-control"
             name="account_number"
             type="number"
             min="1001"
             required
             value="<%= accValue %>"
             <% if (edit) { %>readonly<% } %> >
      <% if (edit) { %>
        <div class="form-text">Account # cannot be changed.</div>
      <% } %>
    </div>

    <div class="mb-3">
      <label class="form-label">Name</label>
      <input class="form-control" name="name" required value="<%= edit ? customer.getName() : "" %>">
    </div>

    <div class="mb-3">
      <label class="form-label">Address</label>
      <textarea class="form-control" name="address" rows="2"><%= edit ? customer.getAddress() : "" %></textarea>
    </div>

   <div class="mb-3">
  <label class="form-label">Phone</label>
  <input type="text"
         class="form-control"
         name="phone"
         pattern="^0[0-9]{9}"
         title="Enter a valid 10-digit phone number starting with 0"
         required
         value="<
  <div class="form-text text-danger">Enter a 10-digit number starting with 0 (e.g., 0771234567)</div>
</div>





     
    <div class="mb-3">
      <label class="form-label">Email (optional)</label>
      <input class="form-control"
             type="email"
             name="email"
             value="<%= edit ? customer.getEmail() : "" %>">
    </div>

    <button class="btn btn-primary"><%= edit ? "Save Changes" : "Create Customer" %></button>
  </form>
</body>
</html>

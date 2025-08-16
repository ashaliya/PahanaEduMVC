<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<%
  String ctx = request.getContextPath();
  Customer c = (Customer) request.getAttribute("c");
%>
<!DOCTYPE html>
<html><head>
  <meta charset="utf-8"><title>Customer • <%= c!=null?c.getName():"" %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:700px;">
  <a class="btn btn-outline-secondary mb-3" href="<%=ctx%>/customers">← Back to list</a>

  <% if (c == null) { %>
    <div class="alert alert-danger">Customer not found.</div>
  <% } else { %>
    <div class="card shadow-sm">
      <div class="card-body">
        <h4 class="mb-3"><%= c.getName() %></h4>
        <dl class="row">
          <dt class="col-sm-4">Account #</dt><dd class="col-sm-8"><%= c.getAccountNumber() %></dd>
          <dt class="col-sm-4">Phone</dt><dd class="col-sm-8"><%= c.getPhone()==null?"—":c.getPhone() %></dd>
          <dt class="col-sm-4">Email</dt><dd class="col-sm-8"><%= c.getEmail()==null?"—":c.getEmail() %></dd>
          <dt class="col-sm-4">Address</dt><dd class="col-sm-8"><pre class="mb-0"><%= c.getAddress()==null?"—":c.getAddress() %></pre></dd>
        </dl>
      </div>
    </div>
  <% } %>
</body></html>

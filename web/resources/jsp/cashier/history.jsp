<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Bill" %>
<% String ctx = request.getContextPath(); List<Bill> bills = (List<Bill>) request.getAttribute("bills"); %>
<!DOCTYPE html>
<html><head>
  <meta charset="utf-8"><title>Bill History</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:900px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Bill History (Last 30 days)</h3>
    <a class="btn btn-outline-secondary" href="<%=ctx%>/jsp/cashier/dashboard.jsp">← Back</a>
  </div>

  <table class="table table-hover align-middle">
    <thead><tr><th>ID</th><th>Date</th><th class="text-end">Total (Rs)</th><th class="text-end">Actions</th></tr></thead>
    <tbody>
    <% if (bills != null) for (Bill b : bills) { %>
      <tr>
        <td><%= b.getId() %></td>
        <td><%= b.getCreatedAt() %></td>
        <td class="text-end"><%= b.getTotal() %></td>
        <td class="text-end">
          <a class="btn btn-sm btn-outline-primary" href="<%=ctx%>/cashier/receipt?id=<%=b.getId()%>">View</a>
        </td>
      </tr>
    <% } %>
    </tbody>
  </table>
</body></html>

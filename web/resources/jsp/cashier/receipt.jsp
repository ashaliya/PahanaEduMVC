<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Bill, model.BillItem, java.util.*" %>
<%
  String ctx = request.getContextPath();
  Bill bill = (Bill) request.getAttribute("bill");
%>
<!DOCTYPE html>
<html><head>
  <meta charset="utf-8"><title>Receipt #<%=bill.getId()%></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:800px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Receipt #<%=bill.getId()%></h3>
    <div>
      <a class="btn btn-outline-secondary btn-sm" href="<%=ctx%>/cashier/bill-history">Bill history</a>
      <button class="btn btn-primary btn-sm" onclick="window.print()">Print</button>
    </div>
  </div>
  <p class="text-muted">Date: <%=bill.getCreatedAt()%></p>

  <table class="table table-bordered align-middle">
    <thead><tr><th>Account Number</th><th>Item</th><th class="text-end">Qty</th><th class="text-end">Price</th><th class="text-end">Total</th></tr></thead>
    <tbody>
    <%
      for (BillItem li : bill.getItems()) {
    %>
      <tr>
        <td><%= li.getItemName()!=null?li.getItemName() : ("#"+li.getItemId()) %></td>
        <td class="text-end"><%= li.getQty() %></td>
        <td class="text-end"><%= li.getPrice() %></td>
        <td class="text-end"><%= li.getLineTotal() %></td>
      </tr>
    <% } %>
    </tbody>
    <tfoot>
      <tr><th colspan="3" class="text-end">Grand Total</th><th class="text-end">Rs <%=bill.getTotal()%></th></tr>
    </tfoot>
  </table>
</body></html>

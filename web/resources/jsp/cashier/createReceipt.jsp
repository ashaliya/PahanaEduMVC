<%@ page contentType="text/html;charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html><head>
  <meta charset="utf-8"><title>Create Receipt</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:900px;">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Create Receipt</h3>
    <a class="btn btn-outline-secondary" href="<%=ctx%>/jsp/cashier/dashboard.jsp">← Back</a>
  </div>

  <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <form method="post" action="<%=ctx%>/cashier/create-receipt">
    <table class="table align-middle" id="lines">
      <thead><tr><th style="width:25%">Account Number</th><th style="width:25%">Item ID</th><th style="width:25%">Qty</th><th>Action</th></tr></thead>
      <tbody>
        <tr>
          <td><input class="form-control" name="Account Number" placeholder="e.g. 1001" required></td>
          <td><input class="form-control" name="itemId" placeholder="e.g. 1" required></td>
          <td><input class="form-control" name="qty" type="number" min="1" value="1" required></td>
          <td><button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">Remove</button></td>
        </tr>
      </tbody>
    </table>

    <div class="d-flex gap-2 mb-3">
      <button type="button" class="btn btn-outline-primary" onclick="addRow()">+ Add line</button>
      <button class="btn btn-success">Create Receipt</button>
    </div>
  </form>

<script>
function addRow(){
  const tr = document.querySelector('#lines tbody tr').cloneNode(true);
  tr.querySelectorAll('input').forEach(inp=>{ if(inp.name==='qty') inp.value=1; else inp.value=''; });
  document.querySelector('#lines tbody').appendChild(tr);
}
function removeRow(btn){
  const rows = document.querySelectorAll('#lines tbody tr');
  if(rows.length>1) btn.closest('tr').remove();
}
</script>
</body></html>

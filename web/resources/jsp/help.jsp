<%@ page contentType="text/html;charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html><head>
  <meta charset="utf-8"><title>Help • PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:900px;">
  <h2 class="mb-3">Help — PahanaEdu System</h2>
  <p class="text-muted">Quick guide for new users.</p>

  <h5>Login</h5>
  <p>Enter your username and password. If you forget your password, contact the Admin.</p>

  <h5>Customer Accounts</h5>
  <ul>
    <li><b>Add New</b> — Go to Customers → New Customer. Fill account number, name, contact details.</li>
    <li><b>Edit</b> — From the list, click “Edit” for the customer. Update details and save.</li>
    <li><b>View</b> — From the list, click “View” to see full details.</li>
  </ul>

  <h5>Items & Billing</h5>
  <ul>
    <li>Stock Keeper manages items (add/edit/restock).</li>
    <li>Cashier creates receipts and views bill history.</li>
  </ul>

  <h5>Support</h5>
  <p>For technical issues, contact your system administrator.</p>
</body></html>

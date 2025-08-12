<!DOCTYPE html>
<html>
<head>
  <title>Cashier Dashboard</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Cashier Dashboard</h2>
  <ul>
    <li><a href="<%=request.getContextPath()%>/jsp/cashier/createReceipt.jsp">Create Receipt</a></li>
    <li><a href="<%=request.getContextPath()%>/cashier/history">Bill History</a></li>
    <li><a class="text-danger" href="<%=request.getContextPath()%>/jsp/shared/logout.jsp">Logout</a></li>
  </ul>
</body>
</html>

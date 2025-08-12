<!DOCTYPE html>
<html>
<head>
  <title>Stock Dashboard</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Stock Keeper Dashboard</h2>
  <ul>
    <li><a href="<%=request.getContextPath()%>/items/list">View Items</a></li>
    <li><a href="<%=request.getContextPath()%>/jsp/stock/addItem.jsp">Add Item</a></li>
    <li><a class="text-danger" href="<%=request.getContextPath()%>/jsp/shared/logout.jsp">Logout</a></li>
  </ul>
</body>
</html>

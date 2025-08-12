<!DOCTYPE html>
<html>
<head>
 <title>Admin Dashboard</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Admin Dashboard</h2>
  <ul>
    <li><a href="<%=request.getContextPath()%>/customers/list">View Customers</a></li>
    <li><a href="<%=request.getContextPath()%>/jsp/admin/addCustomer.jsp">Add Customer</a></li>
    <li><a class="text-danger" href="<%=request.getContextPath()%>/jsp/shared/logout.jsp">Logout</a></li>
  </ul>
</body>
</html>

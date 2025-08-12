<!DOCTYPE html>
<html>
<head>
  <title>Login - PahanaEdu</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-5">
  <h2>Login</h2>
  <form action="<%=request.getContextPath()%>/LoginServlet" method="post" class="col-md-4">
    <div class="mb-3">
      <label class="form-label">Username</label>
      <input class="form-control" name="username" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Password</label>
      <input type="password" class="form-control" name="password" required>
    </div>
    <button class="btn btn-primary">Login</button>
  </form>
  <%
    String err = request.getParameter("error");
    if(err != null){
  %>
    <div class="alert alert-danger mt-3"><%=err%></div>
  <% } %>
</body>
</html>

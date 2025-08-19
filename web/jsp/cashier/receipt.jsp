<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Receipt</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Receipt #${billId}</h2>
  <table class="table table-bordered">
    <thead><tr><th>Item</th><th>Qty</th><th>Price</th><th>Line Total</th></tr></thead>
    <tbody>
      <c:forEach var="li" items="${items}">
        <tr>
          <td>${li.itemName}</td>
          <td>${li.qty}</td>
          <td>${li.price}</td>
          <td>${li.lineTotal}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <a class="btn btn-secondary" href="<%=request.getContextPath()%>/jsp/cashier/dashboard.jsp">Back</a>
</body>
</html>

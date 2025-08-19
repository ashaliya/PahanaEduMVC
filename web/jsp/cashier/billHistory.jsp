<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Bill History</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <h2>Recent Bills</h2>
  <c:choose>
    <c:when test="${empty bills}">
      <div class="alert alert-info">No bills yet.</div>
    </c:when>
    <c:otherwise>
      <table class="table table-bordered">
        <thead><tr><th>ID</th><th>Cashier</th><th>Date</th><th>Total</th><th>Actions</th></tr></thead>
        <tbody>
          <c:forEach var="b" items="${bills}">
            <tr>
              <td>${b.billId}</td>
              <td>${b.cashier}</td>
              <td>${b.createdAt}</td>
              <td>${b.total}</td>
              <td><a class="btn btn-sm btn-outline-primary" href="<%=request.getContextPath()%>/cashier/receipt?billId=${b.billId}">View</a></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</body>
</html>

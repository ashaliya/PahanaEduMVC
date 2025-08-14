<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Items</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Items</h2>
    <div>
      <a class="btn btn-primary btn-sm" href="<%=request.getContextPath()%>/jsp/stock/addItem.jsp">+ Add Item</a>
      <a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/jsp/stock/dashboard.jsp">Back</a>
    </div>
  </div>
  <c:choose>
    <c:when test="${empty items}">
      <div class="alert alert-info">No items found.</div>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table table-bordered">
          <thead><tr><th>ID</th><th>Name</th><th>Price</th><th>Qty</th><th>Actions</th></tr></thead>
          <tbody>
            <c:forEach var="it" items="${items}">
              <tr>
                <td>${it.itemId}</td>
                <td>${it.name}</td>
                <td>${it.price}</td>
                <td>${it.quantity}</td>
                <td>
                  <a class="btn btn-sm btn-outline-primary" href="<%=request.getContextPath()%>/items/edit?id=${it.itemId}">Edit</a>
                  <form action="<%=request.getContextPath()%>/items/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${it.itemId}" />
                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this item?')">Delete</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</body>
</html>

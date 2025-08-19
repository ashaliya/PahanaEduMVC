<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Customers</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Customers</h2>
    <div>
      <a class="btn btn-primary btn-sm" href="<%=request.getContextPath()%>/jsp/admin/addCustomer.jsp">+ Add Customer</a>
      <a class="btn btn-secondary btn-sm" href="<%=request.getContextPath()%>/jsp/admin/dashboard.jsp">Back</a>
    </div>
  </div>
  <c:choose>
    <c:when test="${empty customers}">
      <div class="alert alert-info">No customers found.</div>
    </c:when>
    <c:otherwise>
      <div class="table-responsive">
        <table class="table table-bordered">
          <thead><tr><th>Account #</th><th>Name</th><th>Address</th><th>Phone</th><th>Units</th><th>Actions</th></tr></thead>
          <tbody>
            <c:forEach var="cst" items="${customers}">
              <tr>
                <td>${cst.accountNumber}</td>
                <td>${cst.name}</td>
                <td>${cst.address}</td>
                <td>${cst.phone}</td>
                <td>${cst.unitsConsumed}</td>
                <td>
                  <a class="btn btn-sm btn-outline-primary" href="<%=request.getContextPath()%>/customers/edit?id=${cst.accountNumber}">Edit</a>
                  <form action="<%=request.getContextPath()%>/customers/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${cst.accountNumber}" />
                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this customer?')">Delete</button>
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

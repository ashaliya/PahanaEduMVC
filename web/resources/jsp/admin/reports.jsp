<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
  String ctx = request.getContextPath();
  List<Map<String,Object>> top = (List<Map<String,Object>>)request.getAttribute("top");
  List<Map<String,Object>> rev = (List<Map<String,Object>>)request.getAttribute("rev");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Reports • Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="container my-4">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Reports (Last 30 days)</h3>
    <a class="btn btn-outline-secondary" href="<%=ctx%>/jsp/admin/dashboard.jsp">← Back to dashboard</a>
  </div>

  <div class="row g-4">
    <div class="col-lg-6">
      <div class="card">
        <div class="card-header">Top Sellers</div>
        <div class="card-body">
          <canvas id="topChart" height="140"></canvas>
        </div>
      </div>
    </div>

    <div class="col-lg-6">
      <div class="card">
        <div class="card-header">Revenue by Day</div>
        <div class="card-body">
          <canvas id="revChart" height="140"></canvas>
        </div>
      </div>
    </div>
  </div>

<script>
  // Build arrays for top sellers
  const topLabels = [
    <% if (top != null) {
         for (int i=0;i<top.size();i++) {
           Map<String,Object> m = top.get(i);
           String label = String.valueOf(m.get("itemName")).replace("'", "\\'");
    %>'<%=label%>'<% if (i < top.size()-1) { %>,<% } } } %>
  ];
  const topData = [
    <% if (top != null) {
         for (int i=0;i<top.size();i++) {
           Map<String,Object> m = top.get(i);
    %><%= m.get("totalQty") %><% if (i < top.size()-1) { %>,<% } } } %>
  ];

  // Build arrays for revenue per day
  const revLabels = [
    <% if (rev != null) {
         for (int i=0;i<rev.size();i++) {
           Map<String,Object> m = rev.get(i);
    %>'<%= m.get("day") %>'<% if (i < rev.size()-1) { %>,<% } } } %>
  ];
  const revData = [
    <% if (rev != null) {
         for (int i=0;i<rev.size();i++) {
           Map<String,Object> m = rev.get(i);
    %><%= m.get("total") %><% if (i < rev.size()-1) { %>,<% } } } %>
  ];

  // Charts
  new Chart(document.getElementById('topChart'), {
    type: 'bar',
    data: { labels: topLabels, datasets: [{ label: 'Units', data: topData }] }
  });

  new Chart(document.getElementById('revChart'), {
    type: 'line',
    data: { labels: revLabels, datasets: [{ label: 'Revenue (Rs)', data: revData }] }
  });
</script>
</body>
</html>

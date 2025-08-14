<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.net.URLEncoder, model.Item" %>
<%
    // ---------- SAFE INPUTS / DEFAULTS ----------
    String ctx = request.getContextPath();

    // Read attributes first (from servlet), then fall back to request params
    String qAttr    = (String) request.getAttribute("q");
    String sortAttr = (String) request.getAttribute("sort");
    String dirAttr  = (String) request.getAttribute("dir");
    Object pageAttr = request.getAttribute("page");   // server-side current page
    Object pagesAttr= request.getAttribute("pages");  // server-side total pages
    Object totalAttr= request.getAttribute("total");
    List<Item> itemsAttr = (List<Item>) request.getAttribute("items");

    String q    = (qAttr   != null) ? qAttr   : request.getParameter("q");
    String sort = (sortAttr!= null) ? sortAttr: request.getParameter("sort");
    if (sort == null || sort.isEmpty()) sort = "name";

    String dir  = (dirAttr != null) ? dirAttr : request.getParameter("dir");
    if (dir == null || dir.isEmpty()) dir = "asc";

    int pageNo = 1;              // ✅ use pageNo to avoid JSP implicit 'page'
    try {
        if (pageAttr != null) pageNo = Integer.parseInt(pageAttr.toString());
        else if (request.getParameter("page") != null)
            pageNo = Integer.parseInt(request.getParameter("page"));
    } catch (Exception ignore) { pageNo = 1; }

    int pages = 1;
    try {
        if (pagesAttr != null) pages = Integer.parseInt(pagesAttr.toString());
    } catch (Exception ignore) { pages = 1; }

    int total = 0;
    try {
        if (totalAttr != null) total = Integer.parseInt(totalAttr.toString());
    } catch (Exception ignore) { total = 0; }

    List<Item> items = (itemsAttr != null) ? itemsAttr : Collections.<Item>emptyList();

    String encQ = (q == null) ? "" : URLEncoder.encode(q, "UTF-8");

    // Clamp page numbers just in case
    if (pages < 1) pages = 1;
    if (pageNo < 1) pageNo = 1;
    if (pageNo > pages) pageNo = pages;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Items • Stock</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container my-4" style="max-width:1100px;">
  <div class="d-flex justify-content-between align-items-center mb-1">
    <div>
      <h3 class="mb-0">Item List</h3>
      <small class="text-muted">Total: <%= total %></small>
    </div>
    <a class="btn btn-success" href="<%=ctx%>/stock/items/create">+ Add New Item</a>
  </div>

  <% if (request.getParameter("ok") != null) { %>
    <div class="alert alert-success py-2 my-2">Done: <%=request.getParameter("ok")%></div>
  <% } %>
  <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger py-2 my-2"><%=request.getParameter("error")%></div>
  <% } %>

  <form class="row g-2 mb-3 mt-2" method="get" action="<%=ctx%>/stock/items">
    <div class="col-md-4">
      <input class="form-control" name="q" value="<%= q==null?"":q %>" placeholder="Search by name">
    </div>
    <div class="col-md-3">
      <select class="form-select" name="sort">
        <option value="name"     <%= "name".equalsIgnoreCase(sort)?"selected":"" %>>Sort by Name</option>
        <option value="price"    <%= "price".equalsIgnoreCase(sort)?"selected":"" %>>Sort by Price</option>
        <option value="quantity" <%= "quantity".equalsIgnoreCase(sort)?"selected":"" %>>Sort by Quantity</option>
      </select>
    </div>
    <div class="col-md-2">
      <select class="form-select" name="dir">
        <option value="asc"  <%= "asc".equalsIgnoreCase(dir)?"selected":"" %>>Asc</option>
        <option value="desc" <%= "desc".equalsIgnoreCase(dir)?"selected":"" %>>Desc</option>
      </select>
    </div>
    <div class="col-md-3">
      <button class="btn btn-primary w-100">Search</button>
    </div>
  </form>

  <div class="table-responsive">
    <table class="table table-hover align-middle">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th class="text-end">Price (Rs)</th>
          <th class="text-end">Qty</th>
          <th class="text-end">Actions</th>
        </tr>
      </thead>
      <tbody>
      <% if (!items.isEmpty()) {
           for (Item it : items) { %>
        <tr>
          <td><%= it.getItemId() %></td>
          <td><%= it.getName() %></td>
          <td class="text-end"><%= it.getPrice() %></td>
          <td class="text-end"><%= it.getQuantity() %></td>
          <td class="text-end">
            <a class="btn btn-sm btn-outline-secondary" href="<%=ctx%>/stock/items/edit?id=<%=it.getItemId()%>">Edit</a>
            <form class="d-inline" method="post" action="<%=ctx%>/stock/items/delete" onsubmit="return confirm('Delete this item?');">
              <input type="hidden" name="id" value="<%=it.getItemId()%>">
              <button class="btn btn-sm btn-outline-danger">Delete</button>
            </form>
            <form class="d-inline" method="post" action="<%=ctx%>/stock/items/restock">
              <input type="hidden" name="id" value="<%=it.getItemId()%>">
              <input type="number" name="delta" class="form-control d-inline-block" style="width:90px" value="5" min="1">
              <button class="btn btn-sm btn-outline-success">Restock</button>
            </form>
          </td>
        </tr>
      <% } } else { %>
        <tr><td colspan="5" class="text-center text-muted">No items found</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <nav aria-label="Items pages">
    <ul class="pagination">
      <% for (int p = 1; p <= pages; p++) { %>
        <li class="page-item <%= (p==pageNo) ? "active" : "" %>">
          <a class="page-link"
             href="<%=ctx%>/stock/items?page=<%=p%>&q=<%=encQ%>&sort=<%=sort%>&dir=<%=dir%>"><%=p%></a>
        </li>
      <% } %>
    </ul>
  </nav>
</body>
</html>

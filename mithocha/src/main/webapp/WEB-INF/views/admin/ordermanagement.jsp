<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Order Management</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin.css">
</head>
<body>

<div class="admin-shell">

  <!-- ── Sidebar ── -->
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <div class="sidebar-brand-icon">
        <span class="material-symbols-outlined">local_cafe</span>
      </div>
      <span class="sidebar-brand-name">MithoCha</span>
    </div>

    <nav class="sidebar-nav" aria-label="Admin navigation">
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
        <span class="material-symbols-outlined">dashboard</span>
        Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item active">
        <span class="material-symbols-outlined">receipt_long</span>
        Orders
      </a>
      <a href="${pageContext.request.contextPath}/admin/menu" class="nav-item">
        <span class="material-symbols-outlined">restaurant_menu</span>
        Menu Management
      </a>
      <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item">
        <span class="material-symbols-outlined">people</span>
        Customers
      </a>
      <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item">
        <span class="material-symbols-outlined">inventory_2</span>
        Inventory
      </a>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item">
        <span class="material-symbols-outlined">bar_chart</span>
        Analytics
      </a>
      <a href="${pageContext.request.contextPath}/admin/billing" class="nav-item">
        <span class="material-symbols-outlined">payments</span>
        Billing
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="${pageContext.request.contextPath}/logout" class="nav-item">
        <span class="material-symbols-outlined">logout</span>
        Logout
      </a>
    </div>
  </aside>

  <!-- ── Main ── -->
  <div class="admin-main">

    <!-- Topbar -->
    <header class="admin-topbar">
      <h1 class="topbar-title">Order Management</h1>
      <div class="topbar-actions">
        <span class="topbar-welcome">Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-secondary btn-sm">
          <span class="material-symbols-outlined" style="font-size:16px;">logout</span>
          Logout
        </a>
      </div>
    </header>

    <!-- Content -->
    <main class="admin-content">

      <!-- Flash messages -->
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
          <span class="material-symbols-outlined">check_circle</span>
          ${successMessage}
        </div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
          <span class="material-symbols-outlined">error</span>
          ${errorMessage}
        </div>
      </c:if>

      <!-- Page Header -->
      <div class="page-header">
        <h1>Order Management</h1>
        <p>View and manage all customer orders</p>
      </div>

      <!-- Search Bar -->
      <div class="search-bar">
        <span class="material-symbols-outlined">search</span>
        <input type="text" id="orderSearch" placeholder="Search by order ID or customer..." oninput="filterOrders()">
      </div>

      <!-- Orders Table Card -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">All Orders</h2>
          <span id="orderCount" style="font-size:13px;color:var(--on-surface-variant);font-weight:600;"></span>
        </div>

        <c:choose>
          <c:when test="${not empty orders}">
            <div class="table-wrapper">
              <table class="admin-table" id="ordersTable">
                <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Items</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orders}">
                    <tr class="order-row"
                        data-orderid="${order.orderId}"
                        data-customer="${order.userId}">
                      <td><strong>#${order.orderId}</strong></td>
                      <td>
                        <div style="display:flex;align-items:center;gap:8px;">
                          <div class="avatar-circle">${order.userId}</div>
                          <span>User #${order.userId}</span>
                        </div>
                      </td>
                      <td><strong>Rs. ${order.totalAmount}</strong></td>
                      <td>
                        <span class="status-badge status-${order.status.toLowerCase()}">
                          ${order.status}
                        </span>
                      </td>
                      <td>${order.orderDate}</td>
                      <td>
                        <c:choose>
                          <c:when test="${not empty order.items}">
                            ${order.items.size()} item(s)
                          </c:when>
                          <c:otherwise>—</c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <form method="post"
                              action="${pageContext.request.contextPath}/orders"
                              class="inline-form">
                          <input type="hidden" name="action" value="updateStatus">
                          <input type="hidden" name="orderId" value="${order.orderId}">
                          <select name="status" class="form-control" style="width:auto;padding:6px 32px 6px 10px;">
                            <option value="pending"   ${order.status == 'pending'   ? 'selected' : ''}>Pending</option>
                            <option value="completed" ${order.status == 'completed' ? 'selected' : ''}>Completed</option>
                            <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                          </select>
                          <button type="submit" class="btn-primary btn-sm">Update</button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>

            <!-- Pagination placeholder -->
            <div class="pagination">
              <button class="page-btn active">1</button>
              <button class="page-btn">2</button>
              <button class="page-btn">3</button>
              <button class="page-btn">
                <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
              </button>
            </div>

          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <span class="material-symbols-outlined">receipt_long</span>
              <p>No orders found.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

<script>
  function filterOrders() {
    const query = document.getElementById('orderSearch').value.toLowerCase().trim();
    const rows  = document.querySelectorAll('.order-row');
    let visible = 0;
    rows.forEach(function(row) {
      const orderId   = (row.dataset.orderid  || '').toLowerCase();
      const customer  = (row.dataset.customer || '').toLowerCase();
      const match = orderId.includes(query) || customer.includes(query);
      row.style.display = match ? '' : 'none';
      if (match) visible++;
    });
    const countEl = document.getElementById('orderCount');
    if (countEl) countEl.textContent = visible + ' order(s) shown';
  }

  // Init count
  document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.order-row');
    const countEl = document.getElementById('orderCount');
    if (countEl) countEl.textContent = rows.length + ' order(s)';
  });
</script>

</body>
</html>

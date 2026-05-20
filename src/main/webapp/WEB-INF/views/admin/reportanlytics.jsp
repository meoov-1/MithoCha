<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Reports &amp; Analytics</title>
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
      <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item">
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
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item active">
        <span class="material-symbols-outlined">bar_chart</span>
        Analytics
      </a>
      <a href="${pageContext.request.contextPath}/admin/billing" class="nav-item">
        <span class="material-symbols-outlined">payments</span>
        Billing
      </a>
    </nav>

    <div class="sidebar-footer">
      <button class="nav-item logout-trigger" 
              data-logout-url="${pageContext.request.contextPath}/logout"
              style="background:none;border:none;cursor:pointer;width:100%;text-align:left;color:inherit;font-family:inherit;font-size:inherit;">
          <span class="material-symbols-outlined">logout</span>Logout
      </button>
    </div>
  </aside>

  <!-- ── Main ── -->
  <div class="admin-main">

    <!-- Topbar -->
    <header class="admin-topbar">
      <h1 class="topbar-title">Reports &amp; Analytics</h1>
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

      <!-- Page Header -->
      <div class="page-header">
        <h1>Reports &amp; Analytics</h1>
        <p>Business insights, order trends, and revenue overview</p>
      </div>

      <!-- Stats Grid -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon revenue">
            <span class="material-symbols-outlined">payments</span>
          </div>
          <p class="stat-value">Rs. ${not empty totalRevenue ? totalRevenue : '0.00'}</p>
          <p class="stat-label">Total Revenue</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon orders">
            <span class="material-symbols-outlined">receipt_long</span>
          </div>
          <p class="stat-value">${not empty totalOrders ? totalOrders : 0}</p>
          <p class="stat-label">Total Orders</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon products">
            <span class="material-symbols-outlined">trending_up</span>
          </div>
          <p class="stat-value">Rs. ${not empty avgOrderValue ? avgOrderValue : '0.00'}</p>
          <p class="stat-label">Avg Order Value</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon customers">
            <span class="material-symbols-outlined">people</span>
          </div>
          <p class="stat-value">${not empty totalCustomers ? totalCustomers : 0}</p>
          <p class="stat-label">Total Customers</p>
        </div>
      </div>

      <!-- Three-col grid -->
      <div class="three-col-grid">

        <!-- Orders by Status -->
        <div class="admin-card" style="margin-bottom:0;">
          <div class="card-header">
            <h2 class="card-title">Orders by Status</h2>
          </div>
          <c:choose>
            <c:when test="${not empty ordersByStatus}">
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>Status</th>
                    <th>Count</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="entry" items="${ordersByStatus}">
                    <tr>
                      <td>
                        <span class="status-badge status-${entry.key.toLowerCase()}">
                          ${entry.key}
                        </span>
                      </td>
                      <td><strong>${entry.value}</strong></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
              <div class="empty-state" style="padding:30px 20px;">
                <span class="material-symbols-outlined">receipt_long</span>
                <p>No order data available.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Top Products -->
        <div class="admin-card" style="margin-bottom:0;">
          <div class="card-header">
            <h2 class="card-title">Top Products</h2>
          </div>
          <c:choose>
            <c:when test="${not empty topProducts}">
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Product</th>
                    <th>Orders</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="item" items="${topProducts}" varStatus="loop">
                    <tr>
                      <td style="color:var(--on-surface-variant);font-weight:700;">${loop.index + 1}</td>
                      <td><strong>${item[0]}</strong></td>
                      <td>${item[1]}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
              <div class="empty-state" style="padding:30px 20px;">
                <span class="material-symbols-outlined">restaurant_menu</span>
                <p>No product data available.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Revenue by Month (Chart placeholder) -->
        <div class="admin-card" style="margin-bottom:0;">
          <div class="card-header">
            <h2 class="card-title">Revenue by Month</h2>
          </div>
          <div class="chart-placeholder">
            <span class="material-symbols-outlined">bar_chart</span>
            <p>Revenue chart — integrate Chart.js for live data</p>
          </div>
        </div>

      </div><!-- /three-col-grid -->

      <!-- Spacer -->
      <div style="margin-top:24px;"></div>

      <!-- All Orders Summary -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">All Orders Summary</h2>
          <a href="${pageContext.request.contextPath}/admin/orders" class="btn-secondary btn-sm">Manage Orders</a>
        </div>

        <c:choose>
          <c:when test="${not empty orders}">
            <div class="table-wrapper">
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orders}">
                    <tr>
                      <td><strong>#${order.orderId}</strong></td>
                      <td>User #${order.userId}</td>
                      <td>Rs. ${order.totalAmount}</td>
                      <td>
                        <span class="status-badge status-${order.status.toLowerCase()}">
                          ${order.status}
                        </span>
                      </td>
                      <td>${order.orderDate}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <span class="material-symbols-outlined">receipt_long</span>
              <p>No orders to display.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

</body>
</html>

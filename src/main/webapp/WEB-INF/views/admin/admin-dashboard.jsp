<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Dashboard</title>
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
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
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
      <h1 class="topbar-title">Dashboard</h1>
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

      <!-- Stats Grid -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon orders">
            <span class="material-symbols-outlined">receipt_long</span>
          </div>
          <p class="stat-value">${not empty totalOrders ? totalOrders : 0}</p>
          <p class="stat-label">Total Orders</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon revenue">
            <span class="material-symbols-outlined">payments</span>
          </div>
          <p class="stat-value">Rs. ${not empty totalRevenue ? totalRevenue : '0.00'}</p>
          <p class="stat-label">Total Revenue</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon customers">
            <span class="material-symbols-outlined">people</span>
          </div>
          <p class="stat-value">${not empty totalCustomers ? totalCustomers : 0}</p>
          <p class="stat-label">Total Customers</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon products">
            <span class="material-symbols-outlined">restaurant_menu</span>
          </div>
          <p class="stat-value">${not empty totalProducts ? totalProducts : 0}</p>
          <p class="stat-label">Total Products</p>
        </div>
      </div>

      <!-- Two-col grid: Recent Orders + Quick Actions -->
      <div class="two-col-grid">

        <!-- Recent Orders -->
        <div class="admin-card">
          <div class="card-header">
            <h2 class="card-title">Recent Orders</h2>
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn-secondary btn-sm">View All</a>
          </div>
          <div class="table-wrapper">
            <c:choose>
              <c:when test="${not empty recentOrders}">
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
                    <c:forEach var="order" items="${recentOrders}">
                      <tr>
                        <td><strong>#${order.orderId}</strong></td>
                        <td>${order.userId}</td>
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
              </c:when>
              <c:otherwise>
                <div class="empty-state">
                  <span class="material-symbols-outlined">receipt_long</span>
                  <p>No recent orders found.</p>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="admin-card">
          <div class="card-header">
            <h2 class="card-title">Quick Actions</h2>
          </div>
          <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/admin/menu" class="quick-action-btn">
              <span class="material-symbols-outlined">add_circle</span>
              Add New Product
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="quick-action-btn">
              <span class="material-symbols-outlined">receipt_long</span>
              View All Orders
            </a>
            <a href="${pageContext.request.contextPath}/admin/customers" class="quick-action-btn">
              <span class="material-symbols-outlined">manage_accounts</span>
              Manage Customers
            </a>
            <a href="${pageContext.request.contextPath}/admin/analytics" class="quick-action-btn">
              <span class="material-symbols-outlined">bar_chart</span>
              View Reports
            </a>
          </div>
        </div>

      </div><!-- /two-col-grid -->

      <!-- Low Stock / Unavailable Products -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Low Stock / Unavailable Products</h2>
          <a href="${pageContext.request.contextPath}/admin/inventory" class="btn-secondary btn-sm">Manage Inventory</a>
        </div>
        <div class="table-wrapper">
          <c:choose>
            <c:when test="${not empty unavailableProducts}">
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Base Price</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="product" items="${unavailableProducts}">
                    <tr>
                      <td>
                        <div class="product-cell">
                          <c:if test="${not empty product.imageUrl}">
                            <img src="${product.imageUrl}" alt="${product.name}" class="product-thumb">
                          </c:if>
                          <div class="product-cell-info">
                            <strong>${product.name}</strong>
                          </div>
                        </div>
                      </td>
                      <td>${product.category}</td>
                      <td>Rs. ${product.basePrice}</td>
                      <td>
                        <span class="status-badge status-unavailable">Unavailable</span>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <span class="material-symbols-outlined">check_circle</span>
                <p>All products are available.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

</body>
</html>

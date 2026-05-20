<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Inventory</title>
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
      <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item active">
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
      <h1 class="topbar-title">Inventory</h1>
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
        <h1>Inventory &amp; Stock</h1>
        <p>Monitor product availability and manage stock status</p>
      </div>

      <!-- Stats Row -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon revenue">
            <span class="material-symbols-outlined">check_circle</span>
          </div>
          <p class="stat-value">${not empty availableCount ? availableCount : 0}</p>
          <p class="stat-label">Available Products</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon" style="background:rgba(186,26,26,0.1);color:#ba1a1a;">
            <span class="material-symbols-outlined">cancel</span>
          </div>
          <p class="stat-value">${not empty unavailableCount ? unavailableCount : 0}</p>
          <p class="stat-label">Unavailable Products</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon customers">
            <span class="material-symbols-outlined">category</span>
          </div>
          <p class="stat-value">${not empty categoryCount ? categoryCount : 0}</p>
          <p class="stat-label">Total Categories</p>
        </div>
      </div>

      <!-- Products Inventory Table -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Product Inventory</h2>
          <a href="${pageContext.request.contextPath}/admin/menu" class="btn-primary btn-sm">
            <span class="material-symbols-outlined" style="font-size:16px;">add</span>
            Add Product
          </a>
        </div>

        <!-- Search -->
        <div class="search-bar">
          <span class="material-symbols-outlined">search</span>
          <input type="text" id="inventorySearch" placeholder="Search by product name or category..." oninput="filterInventory()">
        </div>

        <c:choose>
          <c:when test="${not empty products}">
            <div class="table-wrapper">
              <table class="admin-table" id="inventoryTable">
                <thead>
                  <tr>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Base Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="product" items="${products}">
                    <tr class="inventory-row"
                        data-name="${product.name}"
                        data-category="${product.category}">
                      <td>
                        <div class="product-cell">
                          <c:choose>
                            <c:when test="${not empty product.imageUrl}">
                              <img src="${product.imageUrl}" alt="${product.name}" class="product-thumb">
                            </c:when>
                            <c:otherwise>
                              <div class="product-thumb" style="background:var(--surface-container-low);display:flex;align-items:center;justify-content:center;">
                                <span class="material-symbols-outlined" style="font-size:20px;color:var(--on-surface-variant);">image_not_supported</span>
                              </div>
                            </c:otherwise>
                          </c:choose>
                          <div class="product-cell-info">
                            <strong>${product.name}</strong>
                          </div>
                        </div>
                      </td>
                      <td>${product.category}</td>
                      <td>Rs. ${product.basePrice}</td>
                      <td>
                        <c:choose>
                          <c:when test="${product.available}">
                            <span class="status-badge status-active">Available</span>
                          </c:when>
                          <c:otherwise>
                            <span class="status-badge status-unavailable">Unavailable</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <form method="post" action="${pageContext.request.contextPath}/products">
                          <input type="hidden" name="action" value="toggle">
                          <input type="hidden" name="productId" value="${product.productId}">
                          <button type="submit" class="btn-secondary btn-sm">
                            <span class="material-symbols-outlined" style="font-size:15px;">
                              ${product.available ? 'visibility_off' : 'visibility'}
                            </span>
                            ${product.available ? 'Mark Unavailable' : 'Mark Available'}
                          </button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <span class="material-symbols-outlined">inventory_2</span>
              <p>No products in inventory. Add products via Menu Management.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

<script>
  function filterInventory() {
    const query = document.getElementById('inventorySearch').value.toLowerCase().trim();
    const rows  = document.querySelectorAll('.inventory-row');
    rows.forEach(function(row) {
      const name     = (row.dataset.name     || '').toLowerCase();
      const category = (row.dataset.category || '').toLowerCase();
      row.style.display = (name.includes(query) || category.includes(query)) ? '' : 'none';
    });
  }
</script>

</body>
</html>

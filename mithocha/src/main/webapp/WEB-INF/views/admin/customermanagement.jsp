<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Customer Management</title>
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
      <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item active">
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
      <h1 class="topbar-title">Customer Management</h1>
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
        <h1>Customer Management</h1>
        <p>View, search, and manage all registered customers</p>
      </div>

      <!-- Search Bar -->
      <div class="search-bar">
        <span class="material-symbols-outlined">search</span>
        <input type="text" id="customerSearch" placeholder="Search by name, email, or user ID..." oninput="filterCustomers()">
      </div>

      <!-- Customers Table Card -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">All Customers</h2>
          <span id="customerCount" style="font-size:13px;color:var(--on-surface-variant);font-weight:600;"></span>
        </div>

        <c:choose>
          <c:when test="${not empty users}">
            <div class="table-wrapper">
              <table class="admin-table" id="customersTable">
                <thead>
                  <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Joined Date</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="user" items="${users}">
                    <tr class="customer-row"
                        data-userid="${user.userId}"
                        data-name="${user.name}"
                        data-email="${user.email}">
                      <td><strong>#${user.userId}</strong></td>
                      <td>
                        <div style="display:flex;align-items:center;gap:10px;">
                          <div class="avatar-circle">
                            <c:choose>
                              <c:when test="${not empty user.name}">
                                ${user.name.substring(0,1).toUpperCase()}
                              </c:when>
                              <c:otherwise>?</c:otherwise>
                            </c:choose>
                          </div>
                          <span>${user.name}</span>
                        </div>
                      </td>
                      <td>${user.email}</td>
                      <td>
                        <c:choose>
                          <c:when test="${user.role == 'admin'}">
                            <span class="status-badge status-active">Admin</span>
                          </c:when>
                          <c:otherwise>
                            <span class="status-badge status-pending">Customer</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>${user.createdAt}</td>
                      <td>
                        <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap;">
                          <a href="${pageContext.request.contextPath}/admin/customers?id=${user.userId}"
                             class="btn-secondary btn-sm">
                            <span class="material-symbols-outlined" style="font-size:15px;">person</span>
                            View Profile
                          </a>
                          <form method="post"
                                action="${pageContext.request.contextPath}/admin/customers"
                                onsubmit="return confirm('Are you sure you want to delete this user? This action cannot be undone.');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="userId" value="${user.userId}">
                            <button type="submit" class="btn-danger btn-sm">
                              <span class="material-symbols-outlined" style="font-size:15px;">delete</span>
                              Delete
                            </button>
                          </form>
                        </div>
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
              <button class="page-btn">
                <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
              </button>
            </div>

          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <span class="material-symbols-outlined">people</span>
              <p>No customers found.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

<script>
  function filterCustomers() {
    const query = document.getElementById('customerSearch').value.toLowerCase().trim();
    const rows  = document.querySelectorAll('.customer-row');
    let visible = 0;
    rows.forEach(function(row) {
      const userId = (row.dataset.userid || '').toLowerCase();
      const name   = (row.dataset.name   || '').toLowerCase();
      const email  = (row.dataset.email  || '').toLowerCase();
      const match  = userId.includes(query) || name.includes(query) || email.includes(query);
      row.style.display = match ? '' : 'none';
      if (match) visible++;
    });
    const countEl = document.getElementById('customerCount');
    if (countEl) countEl.textContent = visible + ' customer(s) shown';
  }

  document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.customer-row');
    const countEl = document.getElementById('customerCount');
    if (countEl) countEl.textContent = rows.length + ' customer(s)';
  });
</script>

</body>
</html>

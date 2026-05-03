<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Menu Management</title>
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
      <a href="${pageContext.request.contextPath}/admin/menu" class="nav-item active">
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
      <h1 class="topbar-title">Menu Management</h1>
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
        <h1>Menu Management</h1>
        <p>Add, edit, and manage your product catalogue</p>
      </div>

      <!-- ── Add New Product Form ── -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Add New Product</h2>
          <button type="button" class="btn-secondary btn-sm" onclick="toggleAddForm()">
            <span class="material-symbols-outlined" style="font-size:16px;" id="addFormToggleIcon">expand_more</span>
            <span id="addFormToggleLabel">Show Form</span>
          </button>
        </div>

        <div id="addProductForm" style="display:none;">
          <form method="post" action="${pageContext.request.contextPath}/products">
            <input type="hidden" name="action" value="add">

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="productName">Product Name *</label>
                <input type="text" id="productName" name="name" class="form-control"
                       placeholder="e.g. Classic Milk Tea" required>
              </div>

              <div class="form-group">
                <label class="form-label" for="productCategory">Category *</label>
                <select id="productCategory" name="category" class="form-control" required>
                  <option value="" disabled selected>Select a category</option>
                  <option value="Milk Tea">Milk Tea</option>
                  <option value="Fruit Tea">Fruit Tea</option>
                  <option value="Matcha">Matcha</option>
                  <option value="Special">Special</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" for="productDescription">Description</label>
              <textarea id="productDescription" name="description" class="form-control"
                        placeholder="Describe the product flavour, ingredients, etc."></textarea>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="productImageUrl">Image URL</label>
                <input type="url" id="productImageUrl" name="imageUrl" class="form-control"
                       placeholder="https://example.com/image.jpg">
              </div>

              <div class="form-group">
                <label class="form-label" for="productBasePrice">Base Price (Rs.) *</label>
                <input type="number" id="productBasePrice" name="basePrice" class="form-control"
                       placeholder="e.g. 350" min="0" step="0.01" required>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" for="productSizes">Sizes (JSON array)</label>
              <textarea id="productSizes" name="sizes" class="form-control"
                        placeholder='[{"label":"Small","price":0},{"label":"Medium","price":30},{"label":"Large","price":60}]'></textarea>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="productFlavours">Flavours (comma-separated or JSON)</label>
                <textarea id="productFlavours" name="flavours" class="form-control"
                          placeholder='["Original","Taro","Matcha","Strawberry"]'></textarea>
              </div>

              <div class="form-group">
                <label class="form-label" for="productToppings">Toppings (comma-separated or JSON)</label>
                <textarea id="productToppings" name="toppings" class="form-control"
                          placeholder='["Tapioca Pearls","Coconut Jelly","Pudding"]'></textarea>
              </div>
            </div>

            <div class="form-group">
              <label class="form-check">
                <input type="checkbox" name="isAvailable" value="true" checked>
                <span class="form-label" style="text-transform:none;letter-spacing:0;font-size:14px;font-weight:600;">
                  Available for ordering
                </span>
              </label>
            </div>

            <div style="display:flex;gap:12px;margin-top:8px;">
              <button type="submit" class="btn-primary">
                <span class="material-symbols-outlined" style="font-size:18px;">add_circle</span>
                Add Product
              </button>
              <button type="reset" class="btn-secondary">
                <span class="material-symbols-outlined" style="font-size:18px;">restart_alt</span>
                Reset
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- ── All Products Table ── -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">All Products</h2>
          <span id="productCount" style="font-size:13px;color:var(--on-surface-variant);font-weight:600;"></span>
        </div>

        <!-- Search -->
        <div class="search-bar">
          <span class="material-symbols-outlined">search</span>
          <input type="text" id="productSearch" placeholder="Search products..." oninput="filterProducts()">
        </div>

        <c:choose>
          <c:when test="${not empty products}">
            <div class="table-wrapper">
              <table class="admin-table" id="productsTable">
                <thead>
                  <tr>
                    <th>Thumbnail</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Base Price</th>
                    <th>Available</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="product" items="${products}">
                    <tr class="product-row" data-name="${product.name}" data-category="${product.category}">
                      <td>
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
                      </td>
                      <td><strong>${product.name}</strong></td>
                      <td>${product.category}</td>
                      <td>Rs. ${product.basePrice}</td>
                      <td>
                        <c:choose>
                          <c:when test="${product.available}">
                            <span class="status-badge status-active">Yes</span>
                          </c:when>
                          <c:otherwise>
                            <span class="status-badge status-unavailable">No</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap;">
                          <!-- Toggle availability -->
                          <form method="post" action="${pageContext.request.contextPath}/products">
                            <input type="hidden" name="action" value="toggle">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <button type="submit" class="btn-secondary btn-sm">
                              <span class="material-symbols-outlined" style="font-size:15px;">
                                ${product.available ? 'visibility_off' : 'visibility'}
                              </span>
                              ${product.available ? 'Disable' : 'Enable'}
                            </button>
                          </form>
                          <!-- Delete -->
                          <form method="post" action="${pageContext.request.contextPath}/products"
                                onsubmit="return confirm('Delete \'${product.name}\'? This cannot be undone.');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${product.productId}">
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
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <span class="material-symbols-outlined">restaurant_menu</span>
              <p>No products found. Add your first product above.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

<script>
  function toggleAddForm() {
    const form  = document.getElementById('addProductForm');
    const icon  = document.getElementById('addFormToggleIcon');
    const label = document.getElementById('addFormToggleLabel');
    const open  = form.style.display === 'none' || form.style.display === '';
    form.style.display  = open ? 'block' : 'none';
    icon.textContent    = open ? 'expand_less' : 'expand_more';
    label.textContent   = open ? 'Hide Form'   : 'Show Form';
  }

  function filterProducts() {
    const query = document.getElementById('productSearch').value.toLowerCase().trim();
    const rows  = document.querySelectorAll('.product-row');
    let visible = 0;
    rows.forEach(function(row) {
      const name     = (row.dataset.name     || '').toLowerCase();
      const category = (row.dataset.category || '').toLowerCase();
      const match    = name.includes(query) || category.includes(query);
      row.style.display = match ? '' : 'none';
      if (match) visible++;
    });
    const countEl = document.getElementById('productCount');
    if (countEl) countEl.textContent = visible + ' product(s) shown';
  }

  document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.product-row');
    const countEl = document.getElementById('productCount');
    if (countEl) countEl.textContent = rows.length + ' product(s)';
  });
</script>

</body>
</html>

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
  <style>
    /* ── Edit modal ── */
    .edit-overlay { display:none; position:fixed; inset:0; background:rgba(39,24,20,.5); z-index:500; backdrop-filter:blur(3px); }
    .edit-overlay.open { display:block; }
    .edit-modal {
      display:none; position:fixed; top:50%; left:50%;
      transform:translate(-50%,-48%) scale(.96);
      z-index:600; width:min(640px,calc(100vw - 32px));
      max-height:90vh; overflow-y:auto;
      background:#fff; border-radius:20px;
      box-shadow:0 28px 70px rgba(39,24,20,.2);
      opacity:0; transition:transform .25s cubic-bezier(.34,1.56,.64,1), opacity .22s;
    }
    .edit-modal.open { display:block; transform:translate(-50%,-50%) scale(1); opacity:1; }
    .edit-modal-head {
      background:linear-gradient(135deg,#4b2c20,#7d562d);
      padding:22px 28px 16px; color:#fff8f6; position:sticky; top:0; z-index:1;
    }
    .edit-modal-head h2 { font-family:'Noto Serif',serif; font-size:20px; margin:0 0 4px; }
    .edit-modal-head p  { margin:0; font-size:13px; opacity:.85; }
    .edit-modal-body { padding:24px 28px 8px; }
    .edit-modal-foot { display:flex; gap:10px; padding:16px 28px 24px; position:sticky; bottom:0; background:#fff; border-top:1px solid rgba(131,116,111,.12); }
    .edit-modal-foot .btn-cancel {
      flex:1; padding:12px; border:1.5px solid #d5c3bd; border-radius:10px;
      background:transparent; color:#504440; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit;
    }
    .edit-modal-foot .btn-save {
      flex:2; display:inline-flex; align-items:center; justify-content:center; gap:8px;
      padding:12px; border:none; border-radius:10px; background:#7d562d; color:#fff;
      font-size:14px; font-weight:700; cursor:pointer; font-family:inherit;
    }
    .edit-modal-foot .btn-save:hover { filter:brightness(1.08); }
    /* image preview */
    .img-preview { width:80px; height:80px; border-radius:10px; object-fit:cover; border:1px solid #d5c3bd; display:none; }
    .img-preview.visible { display:block; }
  </style>
</head>
<body>
<div class="admin-shell">

  <%-- ── Sidebar ── --%>
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <div class="sidebar-brand-icon"><span class="material-symbols-outlined">local_cafe</span></div>
      <span class="sidebar-brand-name">MithoCha</span>
    </div>
    <nav class="sidebar-nav">
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item"><span class="material-symbols-outlined">dashboard</span>Dashboard</a>
      <a href="${pageContext.request.contextPath}/admin/orders"    class="nav-item"><span class="material-symbols-outlined">receipt_long</span>Orders</a>
      <a href="${pageContext.request.contextPath}/admin/menu"      class="nav-item active"><span class="material-symbols-outlined">restaurant_menu</span>Menu Management</a>
      <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item"><span class="material-symbols-outlined">people</span>Customers</a>
      <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item"><span class="material-symbols-outlined">inventory_2</span>Inventory</a>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item"><span class="material-symbols-outlined">bar_chart</span>Analytics</a>
      <a href="${pageContext.request.contextPath}/admin/billing"   class="nav-item"><span class="material-symbols-outlined">payments</span>Billing</a>
    </nav>
    <div class="sidebar-footer">
      <a href="${pageContext.request.contextPath}/logout" class="nav-item"><span class="material-symbols-outlined">logout</span>Logout</a>
    </div>
  </aside>

  <%-- ── Main ── --%>
  <div class="admin-main">
    <header class="admin-topbar">
      <h1 class="topbar-title">Menu Management</h1>
      <div class="topbar-actions">
        <span class="topbar-welcome">Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-secondary btn-sm">
          <span class="material-symbols-outlined" style="font-size:16px;">logout</span>Logout
        </a>
      </div>
    </header>

    <main class="admin-content">

      <%-- Flash messages --%>
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span>${successMessage}</div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><span class="material-symbols-outlined">error</span>${errorMessage}</div>
      </c:if>

      <div class="page-header">
        <h1>Menu Management</h1>
        <p>Add new products, edit existing ones, toggle availability, and delete items</p>
      </div>

      <%-- ── ADD NEW PRODUCT ── --%>
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Add New Product</h2>
          <button type="button" class="btn-secondary btn-sm" onclick="toggleAddForm()">
            <span class="material-symbols-outlined" style="font-size:16px;" id="addIcon">add</span>
            <span id="addLabel">Show Form</span>
          </button>
        </div>

        <div id="addProductForm" style="display:none;">
          <form method="post" action="${pageContext.request.contextPath}/admin/menu">
            <input type="hidden" name="action" value="add">

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="addName">Product Name *</label>
                <input type="text" id="addName" name="name" class="form-control" placeholder="e.g. Classic Milk Tea" required>
              </div>
              <div class="form-group">
                <label class="form-label" for="addCategory">Category *</label>
                <select id="addCategory" name="category" class="form-control" required>
                  <option value="" disabled selected>Select category</option>
                  <option value="Milk Tea">Milk Tea</option>
                  <option value="Fruit Tea">Fruit Tea</option>
                  <option value="Matcha">Matcha</option>
                  <option value="Special">Special</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" for="addDesc">Description</label>
              <textarea id="addDesc" name="description" class="form-control" rows="3" placeholder="Describe the flavour, ingredients…"></textarea>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="addImageUrl">Image URL</label>
                <input type="url" id="addImageUrl" name="imageUrl" class="form-control"
                       placeholder="https://example.com/image.jpg"
                       oninput="previewImg('addImageUrl','addImgPreview')">
                <img id="addImgPreview" class="img-preview" alt="Preview">
              </div>
              <div class="form-group">
                <label class="form-label" for="addBasePrice">Base Price (Rs.) *</label>
                <input type="number" id="addBasePrice" name="basePrice" class="form-control"
                       placeholder="e.g. 350" min="0" step="0.01" required>
              </div>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="form-label" for="addSizes">Sizes (JSON)</label>
                <textarea id="addSizes" name="sizes" class="form-control" rows="2"
                          placeholder='[{"label":"Regular","price":0},{"label":"Large","price":50}]'></textarea>
              </div>
              <div class="form-group">
                <label class="form-label" for="addFlavours">Flavours (JSON or comma-list)</label>
                <textarea id="addFlavours" name="flavours" class="form-control" rows="2"
                          placeholder='["Original","Taro","Matcha"]'></textarea>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label" for="addToppings">Toppings (JSON or comma-list)</label>
              <textarea id="addToppings" name="toppings" class="form-control" rows="2"
                        placeholder='["Tapioca Pearls","Coconut Jelly","Pudding"]'></textarea>
            </div>

            <div class="form-group">
              <label class="form-check">
                <input type="checkbox" name="isAvailable" value="true" checked>
                <span style="font-size:14px;font-weight:600;color:#271814;">Available for ordering</span>
              </label>
            </div>

            <div style="display:flex;gap:12px;margin-top:4px;">
              <button type="submit" class="btn-primary">
                <span class="material-symbols-outlined" style="font-size:18px;">add_circle</span>Add Product
              </button>
              <button type="reset" class="btn-secondary">
                <span class="material-symbols-outlined" style="font-size:18px;">restart_alt</span>Reset
              </button>
            </div>
          </form>
        </div>
      </div>

      <%-- ── PRODUCTS TABLE ── --%>
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">All Products</h2>
          <span id="productCount" style="font-size:13px;color:var(--on-surface-variant);font-weight:600;"></span>
        </div>

        <div class="search-bar">
          <span class="material-symbols-outlined">search</span>
          <input type="text" id="productSearch" placeholder="Search by name or category…" oninput="filterProducts()">
        </div>

        <c:choose>
          <c:when test="${not empty products}">
            <div class="table-wrapper">
              <table class="admin-table" id="productsTable">
                <thead>
                  <tr>
                    <th>Image</th>
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
                            <div class="product-thumb" style="background:#fff1ed;display:flex;align-items:center;justify-content:center;">
                              <span class="material-symbols-outlined" style="font-size:20px;color:#d5c3bd;">image_not_supported</span>
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
                        <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap;">

                          <%-- Edit button → opens modal --%>
                          <button type="button" class="btn-primary btn-sm"
                                  onclick="openEditModal(
                                    ${product.productId},
                                    '${product.name.replace("'","\\'")}',
                                    '${product.category}',
                                    '${product.description != null ? product.description.replace("'","\\'").replace(chr(10)," ") : ""}',
                                    '${product.imageUrl != null ? product.imageUrl : ""}',
                                    '${product.basePrice}',
                                    '${product.sizes != null ? product.sizes.replace("'","\\'") : ""}',
                                    '${product.flavours != null ? product.flavours.replace("'","\\'") : ""}',
                                    '${product.toppings != null ? product.toppings.replace("'","\\'") : ""}',
                                    ${product.available}
                                  )">
                            <span class="material-symbols-outlined" style="font-size:15px;">edit</span>Edit
                          </button>

                          <%-- Toggle availability --%>
                          <form method="post" action="${pageContext.request.contextPath}/admin/menu">
                            <input type="hidden" name="action"    value="toggle">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <button type="submit" class="btn-secondary btn-sm">
                              <span class="material-symbols-outlined" style="font-size:15px;">
                                ${product.available ? 'visibility_off' : 'visibility'}
                              </span>
                              ${product.available ? 'Disable' : 'Enable'}
                            </button>
                          </form>

                          <%-- Delete --%>
                          <form method="post" action="${pageContext.request.contextPath}/admin/menu"
                                onsubmit="return confirm('Delete \'${product.name}\'? This cannot be undone.');">
                            <input type="hidden" name="action"    value="delete">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <button type="submit" class="btn-danger btn-sm">
                              <span class="material-symbols-outlined" style="font-size:15px;">delete</span>Delete
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
              <p>No products yet. Add your first product above.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div>
</div>

<%-- ── Edit Product Modal ── --%>
<div id="editOverlay" class="edit-overlay" onclick="closeEditModal()"></div>
<div id="editModal" class="edit-modal" role="dialog" aria-modal="true">
  <div class="edit-modal-head">
    <span class="material-symbols-outlined" style="font-size:32px;display:block;margin-bottom:8px;">edit</span>
    <h2>Edit Product</h2>
    <p id="editModalSubtitle">Update product details below.</p>
  </div>
  <div class="edit-modal-body">
    <form id="editForm" method="post" action="${pageContext.request.contextPath}/admin/menu">
      <input type="hidden" name="action"    value="edit">
      <input type="hidden" name="productId" id="editProductId">

      <div class="form-grid">
        <div class="form-group">
          <label class="form-label" for="editName">Product Name *</label>
          <input type="text" id="editName" name="name" class="form-control" required>
        </div>
        <div class="form-group">
          <label class="form-label" for="editCategory">Category *</label>
          <select id="editCategory" name="category" class="form-control" required>
            <option value="Milk Tea">Milk Tea</option>
            <option value="Fruit Tea">Fruit Tea</option>
            <option value="Matcha">Matcha</option>
            <option value="Special">Special</option>
          </select>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="editDesc">Description</label>
        <textarea id="editDesc" name="description" class="form-control" rows="3"></textarea>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label class="form-label" for="editImageUrl">Image URL</label>
          <input type="url" id="editImageUrl" name="imageUrl" class="form-control"
                 oninput="previewImg('editImageUrl','editImgPreview')">
          <img id="editImgPreview" class="img-preview" alt="Preview">
        </div>
        <div class="form-group">
          <label class="form-label" for="editBasePrice">Base Price (Rs.) *</label>
          <input type="number" id="editBasePrice" name="basePrice" class="form-control" min="0" step="0.01" required>
        </div>
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label class="form-label" for="editSizes">Sizes (JSON)</label>
          <textarea id="editSizes" name="sizes" class="form-control" rows="2"></textarea>
        </div>
        <div class="form-group">
          <label class="form-label" for="editFlavours">Flavours</label>
          <textarea id="editFlavours" name="flavours" class="form-control" rows="2"></textarea>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="editToppings">Toppings</label>
        <textarea id="editToppings" name="toppings" class="form-control" rows="2"></textarea>
      </div>

      <div class="form-group">
        <label class="form-check">
          <input type="checkbox" id="editAvailable" name="isAvailable" value="true">
          <span style="font-size:14px;font-weight:600;color:#271814;">Available for ordering</span>
        </label>
      </div>
    </form>
  </div>
  <div class="edit-modal-foot">
    <button type="button" class="btn-cancel" onclick="closeEditModal()">Cancel</button>
    <button type="button" class="btn-save" onclick="document.getElementById('editForm').submit()">
      <span class="material-symbols-outlined" style="font-size:18px;">save</span>Save Changes
    </button>
  </div>
</div>

<script>
  /* ── Add form toggle ── */
  function toggleAddForm() {
    var form  = document.getElementById('addProductForm');
    var icon  = document.getElementById('addIcon');
    var label = document.getElementById('addLabel');
    var open  = form.style.display === 'none' || form.style.display === '';
    form.style.display = open ? 'block' : 'none';
    icon.textContent   = open ? 'expand_less' : 'add';
    label.textContent  = open ? 'Hide Form'   : 'Show Form';
  }

  /* ── Product search ── */
  function filterProducts() {
    var query = (document.getElementById('productSearch').value || '').toLowerCase().trim();
    var rows  = document.querySelectorAll('.product-row');
    var visible = 0;
    rows.forEach(function(row) {
      var name     = (row.dataset.name     || '').toLowerCase();
      var category = (row.dataset.category || '').toLowerCase();
      var show = !query || name.includes(query) || category.includes(query);
      row.style.display = show ? '' : 'none';
      if (show) visible++;
    });
    var countEl = document.getElementById('productCount');
    if (countEl) countEl.textContent = visible + ' product(s)';
  }

  /* ── Image URL preview ── */
  function previewImg(inputId, imgId) {
    var url = document.getElementById(inputId).value.trim();
    var img = document.getElementById(imgId);
    if (url) { img.src = url; img.classList.add('visible'); }
    else      { img.src = ''; img.classList.remove('visible'); }
  }

  /* ── Edit modal ── */
  function openEditModal(id, name, category, description, imageUrl, basePrice, sizes, flavours, toppings, available) {
    document.getElementById('editProductId').value  = id;
    document.getElementById('editName').value       = name;
    document.getElementById('editDesc').value       = description;
    document.getElementById('editImageUrl').value   = imageUrl;
    document.getElementById('editBasePrice').value  = basePrice;
    document.getElementById('editSizes').value      = sizes;
    document.getElementById('editFlavours').value   = flavours;
    document.getElementById('editToppings').value   = toppings;
    document.getElementById('editAvailable').checked = available;
    document.getElementById('editModalSubtitle').textContent = 'Editing: ' + name;

    // Set category select
    var sel = document.getElementById('editCategory');
    for (var i = 0; i < sel.options.length; i++) {
      if (sel.options[i].value === category) { sel.selectedIndex = i; break; }
    }

    // Show image preview
    previewImg('editImageUrl', 'editImgPreview');

    document.getElementById('editModal').classList.add('open');
    document.getElementById('editOverlay').classList.add('open');
    document.body.style.overflow = 'hidden';
    document.getElementById('editName').focus();
  }

  function closeEditModal() {
    document.getElementById('editModal').classList.remove('open');
    document.getElementById('editOverlay').classList.remove('open');
    document.body.style.overflow = '';
  }

  document.addEventListener('keydown', function(e){ if(e.key==='Escape') closeEditModal(); });

  /* ── Init count ── */
  document.addEventListener('DOMContentLoaded', function() {
    var rows = document.querySelectorAll('.product-row');
    var countEl = document.getElementById('productCount');
    if (countEl) countEl.textContent = rows.length + ' product(s)';
  });
</script>
</body>
</html>

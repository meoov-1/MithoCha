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
  <style>
    /* ── Mark-as-Paid modal ── */
    .paid-overlay { display:none; position:fixed; inset:0; background:rgba(39,24,20,.5); z-index:500; backdrop-filter:blur(3px); }
    .paid-overlay.open { display:block; }
    .paid-modal {
      display:none; position:fixed; top:50%; left:50%;
      transform:translate(-50%,-48%) scale(.96);
      z-index:600; width:min(460px,calc(100vw - 32px));
      background:#fff; border-radius:20px;
      box-shadow:0 28px 70px rgba(39,24,20,.2);
      overflow:hidden; opacity:0;
      transition:transform .25s cubic-bezier(.34,1.56,.64,1), opacity .22s;
    }
    .paid-modal.open { display:block; transform:translate(-50%,-50%) scale(1); opacity:1; }
    .paid-modal-head { background:linear-gradient(135deg,#2f7d32,#4caf50); padding:24px 28px 18px; color:#fff; }
    .paid-modal-head h2 { font-family:'Noto Serif',serif; font-size:20px; margin:0 0 4px; }
    .paid-modal-head p  { margin:0; font-size:13px; opacity:.88; }
    .paid-modal-body { padding:22px 28px 8px; display:flex; flex-direction:column; gap:14px; }
    .paid-modal-foot { display:flex; gap:10px; padding:16px 28px 24px; }
    .paid-modal-foot .btn-cancel {
      flex:1; padding:12px; border:1.5px solid #d5c3bd; border-radius:10px;
      background:transparent; color:#504440; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit;
    }
    .paid-modal-foot .btn-confirm {
      flex:2; display:inline-flex; align-items:center; justify-content:center; gap:8px;
      padding:12px; border:none; border-radius:10px; background:#2f7d32; color:#fff;
      font-size:14px; font-weight:700; cursor:pointer; font-family:inherit;
    }
    .paid-modal-foot .btn-confirm:hover { filter:brightness(1.08); }
    /* order detail expand */
    .order-detail-row { display:none; background:#fff9f7; }
    .order-detail-row.open { display:table-row; }
    .order-detail-cell { padding:16px 20px !important; border-bottom:1px solid rgba(131,116,111,.1) !important; }
    .detail-dl { display:grid; grid-template-columns:repeat(auto-fit,minmax(160px,1fr)); gap:12px; }
    .detail-dl dt { font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:.08em; color:#504440; margin-bottom:3px; }
    .detail-dl dd { font-size:14px; color:#271814; font-weight:500; margin:0; word-break:break-word; }
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
      <a href="${pageContext.request.contextPath}/admin/orders"    class="nav-item active"><span class="material-symbols-outlined">receipt_long</span>Orders</a>
      <a href="${pageContext.request.contextPath}/admin/menu"      class="nav-item"><span class="material-symbols-outlined">restaurant_menu</span>Menu Management</a>
      <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item"><span class="material-symbols-outlined">people</span>Customers</a>
      <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item"><span class="material-symbols-outlined">inventory_2</span>Inventory</a>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item"><span class="material-symbols-outlined">bar_chart</span>Analytics</a>
      <a href="${pageContext.request.contextPath}/admin/billing"   class="nav-item"><span class="material-symbols-outlined">payments</span>Billing</a>
    </nav>
  </aside>

  <%-- ── Main ── --%>
  <div class="admin-main">
    <header class="admin-topbar">
      <h1 class="topbar-title">Order Management</h1>
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
        <h1>Order Management</h1>
        <p>View, update status, and mark payments for all customer orders</p>
      </div>

      <%-- Status filter tabs --%>
      <div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:20px;">
        <button class="filter-tab active" onclick="filterByStatus('all',this)">All</button>
        <button class="filter-tab" onclick="filterByStatus('pending',this)">Pending</button>
        <button class="filter-tab" onclick="filterByStatus('completed',this)">Completed</button>
        <button class="filter-tab" onclick="filterByStatus('cancelled',this)">Cancelled</button>
      </div>

      <div class="search-bar">
        <span class="material-symbols-outlined">search</span>
        <input type="text" id="orderSearch" placeholder="Search by order ID or customer ID…" oninput="filterOrders()">
      </div>

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
                    <th>Customer</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Date</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orders}">
                    <tr class="order-row"
                        data-orderid="${order.orderId}"
                        data-customer="${order.userId}"
                        data-status="${order.status}">
                      <td><strong>#${order.orderId}</strong></td>
                      <td>
                        <div style="display:flex;align-items:center;gap:8px;">
                          <div class="avatar-circle">${order.userId}</div>
                          <span>User #${order.userId}</span>
                        </div>
                      </td>
                      <td><strong>Rs. ${order.totalAmount}</strong></td>
                      <td>
                        <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${order.status == 'completed' or order.status == 'paid'}">
                            <span class="status-badge status-completed">Paid</span>
                          </c:when>
                          <c:when test="${order.status == 'cancelled'}">
                            <span class="status-badge status-cancelled">Cancelled</span>
                          </c:when>
                          <c:otherwise>
                            <span class="status-badge status-pending">Unpaid</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td style="font-size:13px;color:#504440;">${order.orderDate}</td>
                      <td>
                        <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap;">

                          <%-- Status update --%>
                          <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="inline-form">
                            <input type="hidden" name="action"  value="updateStatus">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <select name="status" class="form-control" style="width:auto;padding:6px 32px 6px 10px;">
                              <option value="pending"   ${order.status == 'pending'   ? 'selected' : ''}>Pending</option>
                              <option value="completed" ${order.status == 'completed' ? 'selected' : ''}>Completed</option>
                              <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <button type="submit" class="btn-primary btn-sm">Update</button>
                          </form>

                          <%-- Mark as Paid button (only for pending orders) --%>
                          <c:if test="${order.status == 'pending'}">
                            <button type="button" class="btn-paid btn-sm"
                                    onclick="openPaidModal(${order.orderId}, 'Rs. ${order.totalAmount}')"
                                    style="background:rgba(47,125,50,.12);color:#246328;border:none;padding:7px 14px;border-radius:8px;font-size:13px;font-weight:700;cursor:pointer;display:inline-flex;align-items:center;gap:6px;">
                              <span class="material-symbols-outlined" style="font-size:15px;">check_circle</span>
                              Mark Paid
                            </button>
                          </c:if>

                          <%-- Expand detail --%>
                          <button type="button" class="btn-secondary btn-sm"
                                  onclick="toggleDetail('od-${order.orderId}', this)"
                                  style="padding:7px 10px;">
                            <span class="material-symbols-outlined" style="font-size:16px;">expand_more</span>
                          </button>
                        </div>
                      </td>
                    </tr>

                    <%-- Expandable detail row --%>
                    <tr class="order-detail-row" id="od-${order.orderId}">
                      <td class="order-detail-cell" colspan="7">
                        <dl class="detail-dl">
                          <div><dt>Order ID</dt><dd>#${order.orderId}</dd></div>
                          <div><dt>Customer</dt><dd>User #${order.userId}</dd></div>
                          <div><dt>Total</dt><dd>Rs. ${order.totalAmount}</dd></div>
                          <div><dt>Status</dt><dd><span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span></dd></div>
                          <div><dt>Date</dt><dd>${order.orderDate}</dd></div>
                          <c:if test="${not empty order.shippingAddress}">
                            <div><dt>Shipping</dt><dd>${order.shippingAddress}</dd></div>
                          </c:if>
                          <c:if test="${not empty order.payment}">
                            <div><dt>Payment Info</dt><dd style="font-size:12px;word-break:break-all;">${order.payment}</dd></div>
                          </c:if>
                          <c:if test="${not empty order.items}">
                            <div style="grid-column:1/-1;"><dt>Items</dt><dd style="font-size:12px;word-break:break-all;">${order.items}</dd></div>
                          </c:if>
                        </dl>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
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
  </div>
</div>

<%-- ── Mark-as-Paid Modal ── --%>
<div id="paidOverlay" class="paid-overlay" onclick="closePaidModal()"></div>
<div id="paidModal" class="paid-modal" role="dialog" aria-modal="true">
  <div class="paid-modal-head">
    <span class="material-symbols-outlined" style="font-size:36px;display:block;margin-bottom:8px;">payments</span>
    <h2>Mark Order as Paid</h2>
    <p id="paidModalSubtitle">Confirm payment receipt for this order.</p>
  </div>
  <div class="paid-modal-body">
    <div class="form-group">
      <label class="form-label">Payment Method</label>
      <select id="paidMethod" class="form-control">
        <option value="cash">Cash on Delivery (collected)</option>
        <option value="fonepay">Fonepay</option>
        <option value="khalti">Khalti</option>
        <option value="esewa">eSewa</option>
        <option value="bank_transfer">Bank Transfer</option>
        <option value="other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label class="form-label">Transaction / Reference ID <span style="font-weight:400;text-transform:none;">(optional)</span></label>
      <input type="text" id="paidTxnId" class="form-control" placeholder="e.g. TXN-20260503-001">
    </div>
    <p id="paidModalError" style="display:none;color:#9c1515;font-size:13px;font-weight:600;background:rgba(186,26,26,.08);border-radius:8px;padding:10px 14px;"></p>
  </div>
  <form id="paidForm" method="post" action="${pageContext.request.contextPath}/admin/orders">
    <input type="hidden" name="action"        value="markPaid">
    <input type="hidden" name="orderId"       id="paidOrderId">
    <input type="hidden" name="paymentMethod" id="paidMethodHidden">
    <input type="hidden" name="transactionId" id="paidTxnHidden">
    <div class="paid-modal-foot">
      <button type="button" class="btn-cancel" onclick="closePaidModal()">Cancel</button>
      <button type="button" class="btn-confirm" onclick="submitPaid()">
        <span class="material-symbols-outlined" style="font-size:18px;">check_circle</span>
        Confirm Payment
      </button>
    </div>
  </form>
</div>

<script>
  /* ── Filter tabs ── */
  var currentStatus = 'all';
  function filterByStatus(status, btn) {
    currentStatus = status;
    document.querySelectorAll('.filter-tab').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');
    applyFilters();
  }

  /* ── Search ── */
  function filterOrders() { applyFilters(); }

  function applyFilters() {
    var query = (document.getElementById('orderSearch').value || '').toLowerCase().trim();
    var rows  = document.querySelectorAll('.order-row');
    var visible = 0;
    rows.forEach(function(row) {
      var orderId  = (row.dataset.orderid  || '').toLowerCase();
      var customer = (row.dataset.customer || '').toLowerCase();
      var status   = (row.dataset.status   || '').toLowerCase();
      var matchSearch = !query || orderId.includes(query) || customer.includes(query);
      var matchStatus = currentStatus === 'all' || status === currentStatus;
      var show = matchSearch && matchStatus;
      row.style.display = show ? '' : 'none';
      // Also hide detail row when parent is hidden
      var detailRow = document.getElementById('od-' + row.dataset.orderid);
      if (detailRow && !show) { detailRow.style.display = 'none'; detailRow.classList.remove('open'); }
      if (show) visible++;
    });
    var countEl = document.getElementById('orderCount');
    if (countEl) countEl.textContent = visible + ' order(s)';
  }

  /* ── Detail expand ── */
  function toggleDetail(id, btn) {
    var row = document.getElementById(id);
    if (!row) return;
    var open = row.classList.toggle('open');
    var icon = btn.querySelector('.material-symbols-outlined');
    if (icon) icon.textContent = open ? 'expand_less' : 'expand_more';
  }

  /* ── Mark-as-Paid modal ── */
  function openPaidModal(orderId, amount) {
    document.getElementById('paidOrderId').value = orderId;
    document.getElementById('paidModalSubtitle').textContent = 'Order #' + orderId + ' — ' + amount;
    document.getElementById('paidTxnId').value = '';
    document.getElementById('paidModalError').style.display = 'none';
    document.getElementById('paidModal').classList.add('open');
    document.getElementById('paidOverlay').classList.add('open');
    document.body.style.overflow = 'hidden';
  }
  function closePaidModal() {
    document.getElementById('paidModal').classList.remove('open');
    document.getElementById('paidOverlay').classList.remove('open');
    document.body.style.overflow = '';
  }
  function submitPaid() {
    var method = document.getElementById('paidMethod').value;
    var txn    = document.getElementById('paidTxnId').value.trim();
    document.getElementById('paidMethodHidden').value = method;
    document.getElementById('paidTxnHidden').value    = txn || ('ADMIN-' + Date.now());
    document.getElementById('paidForm').submit();
  }
  document.addEventListener('keydown', function(e){ if(e.key==='Escape') closePaidModal(); });

  /* ── Init count ── */
  document.addEventListener('DOMContentLoaded', function() {
    var rows = document.querySelectorAll('.order-row');
    var countEl = document.getElementById('orderCount');
    if (countEl) countEl.textContent = rows.length + ' order(s)';
  });
</script>

<style>
  .filter-tab {
    padding:8px 18px; border-radius:999px; border:1.5px solid #d5c3bd;
    background:#fff; color:#504440; font-size:13px; font-weight:700;
    cursor:pointer; font-family:inherit; transition:all .2s;
  }
  .filter-tab:hover { border-color:#7d562d; color:#7d562d; }
  .filter-tab.active { background:#7d562d; border-color:#7d562d; color:#fff; }
</style>
</body>
</html>

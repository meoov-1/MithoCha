<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Billing &amp; Payments</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin.css">
  <style>
    .billing-detail { display:none; background:var(--surface-container-low); }
    .billing-detail.open { display:table-row; }
    .billing-detail td { padding:16px 20px !important; border-bottom:1px solid rgba(131,116,111,.1) !important; }
    .detail-dl { display:grid; grid-template-columns:repeat(auto-fit,minmax(160px,1fr)); gap:14px; }
    .detail-dl dt { font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:.08em; color:var(--on-surface-variant); margin-bottom:4px; }
    .detail-dl dd { font-size:14px; color:#271814; font-weight:500; margin:0; word-break:break-word; }
    /* Mark-as-Paid modal (reuse same styles as orders page) */
    .paid-overlay { display:none; position:fixed; inset:0; background:rgba(39,24,20,.5); z-index:500; backdrop-filter:blur(3px); }
    .paid-overlay.open { display:block; }
    .paid-modal {
      display:none; position:fixed; top:50%; left:50%;
      transform:translate(-50%,-48%) scale(.96); z-index:600;
      width:min(460px,calc(100vw - 32px)); background:#fff; border-radius:20px;
      box-shadow:0 28px 70px rgba(39,24,20,.2); opacity:0;
      transition:transform .25s cubic-bezier(.34,1.56,.64,1), opacity .22s;
    }
    .paid-modal.open { display:block; transform:translate(-50%,-50%) scale(1); opacity:1; }
    .paid-modal-head { background:linear-gradient(135deg,#2f7d32,#4caf50); padding:24px 28px 18px; color:#fff; }
    .paid-modal-head h2 { font-family:'Noto Serif',serif; font-size:20px; margin:0 0 4px; }
    .paid-modal-head p  { margin:0; font-size:13px; opacity:.88; }
    .paid-modal-body { padding:22px 28px 8px; display:flex; flex-direction:column; gap:14px; }
    .paid-modal-foot { display:flex; gap:10px; padding:16px 28px 24px; }
    .paid-modal-foot .btn-cancel { flex:1; padding:12px; border:1.5px solid #d5c3bd; border-radius:10px; background:transparent; color:#504440; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit; }
    .paid-modal-foot .btn-confirm { flex:2; display:inline-flex; align-items:center; justify-content:center; gap:8px; padding:12px; border:none; border-radius:10px; background:#2f7d32; color:#fff; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit; }
  </style>
    }
    .detail-dl dt {
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      color: var(--on-surface-variant);
      margin-bottom: 4px;
    }
    .detail-dl dd {
      font-size: 14px;
      color: #271814;
      font-weight: 500;
      margin: 0;
      word-break: break-word;
    }
  </style>
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
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item">
        <span class="material-symbols-outlined">bar_chart</span>
        Analytics
      </a>
      <a href="${pageContext.request.contextPath}/admin/billing" class="nav-item active">
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
      <h1 class="topbar-title">Billing &amp; Payments</h1>
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
        <h1>Billing &amp; Payments</h1>
        <p>Track payment records, revenue, and order financial status</p>
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
          <div class="stat-icon" style="background:rgba(47,125,50,0.1);color:#2f7d32;">
            <span class="material-symbols-outlined">check_circle</span>
          </div>
          <p class="stat-value">${not empty paidOrders ? paidOrders : 0}</p>
          <p class="stat-label">Paid Orders</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon orders">
            <span class="material-symbols-outlined">pending</span>
          </div>
          <p class="stat-value">${not empty pendingOrders ? pendingOrders : 0}</p>
          <p class="stat-label">Pending Payments</p>
        </div>

        <div class="stat-card">
          <div class="stat-icon" style="background:rgba(186,26,26,0.1);color:#ba1a1a;">
            <span class="material-symbols-outlined">cancel</span>
          </div>
          <p class="stat-value">${not empty cancelledOrders ? cancelledOrders : 0}</p>
          <p class="stat-label">Cancelled</p>
        </div>
      </div>

      <!-- Payment Records Table -->
      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Payment Records</h2>
          <span id="billingCount" style="font-size:13px;color:var(--on-surface-variant);font-weight:600;"></span>
        </div>

        <!-- Search -->
        <div class="search-bar">
          <span class="material-symbols-outlined">search</span>
          <input type="text" id="billingSearch" placeholder="Search by order ID or customer..." oninput="filterBilling()">
        </div>

        <c:choose>
          <c:when test="${not empty orders}">
            <div class="table-wrapper">
              <table class="admin-table" id="billingTable">
                <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Amount</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Details</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orders}" varStatus="loop">
                    <%-- Determine payment method from order.payment JSON if available --%>
                    <tr class="billing-row"
                        data-orderid="${order.orderId}"
                        data-customer="${order.userId}">
                      <td><strong>#${order.orderId}</strong></td>
                      <td>User #${order.userId}</td>
                      <td><strong>Rs. ${order.totalAmount}</strong></td>
                      <td>
                        <c:choose>
                          <c:when test="${not empty order.payment}">
                            <span style="font-size:13px;font-weight:600;">${order.payment}</span>
                          </c:when>
                          <c:otherwise>
                            <span style="color:var(--on-surface-variant);font-size:13px;">—</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <span class="status-badge status-${order.status.toLowerCase()}">
                          ${order.status}
                        </span>
                      </td>
                      <td>${order.orderDate}</td>
                      <td>
                        <button type="button"
                                class="btn-secondary btn-sm"
                                onclick="toggleDetail('detail-${order.orderId}', this)"
                                aria-expanded="false"
                                aria-controls="detail-${order.orderId}">
                          <span class="material-symbols-outlined" style="font-size:15px;">expand_more</span>
                          View Details
                        </button>
                        <%-- Mark as Paid (only for pending orders) --%>
                        <c:if test="${order.status == 'pending'}">
                          <button type="button"
                                  onclick="openPaidModal(${order.orderId}, 'Rs. ${order.totalAmount}')"
                                  style="background:rgba(47,125,50,.12);color:#246328;border:none;padding:7px 14px;border-radius:8px;font-size:13px;font-weight:700;cursor:pointer;display:inline-flex;align-items:center;gap:6px;margin-top:4px;">
                            <span class="material-symbols-outlined" style="font-size:15px;">check_circle</span>
                            Mark Paid
                          </button>
                        </c:if>
                      </td>
                    </tr>

                    <!-- Inline detail expand row -->
                    <tr class="billing-detail" id="detail-${order.orderId}">
                      <td colspan="7">
                        <dl class="detail-dl">
                          <div>
                            <dt>Order ID</dt>
                            <dd>#${order.orderId}</dd>
                          </div>
                          <div>
                            <dt>Customer ID</dt>
                            <dd>${order.userId}</dd>
                          </div>
                          <div>
                            <dt>Total Amount</dt>
                            <dd>Rs. ${order.totalAmount}</dd>
                          </div>
                          <div>
                            <dt>Status</dt>
                            <dd>
                              <span class="status-badge status-${order.status.toLowerCase()}">
                                ${order.status}
                              </span>
                            </dd>
                          </div>
                          <div>
                            <dt>Order Date</dt>
                            <dd>${order.orderDate}</dd>
                          </div>
                          <div>
                            <dt>Payment Info</dt>
                            <dd>
                              <c:choose>
                                <c:when test="${not empty order.payment}">
                                  ${order.payment}
                                </c:when>
                                <c:otherwise>Not recorded</c:otherwise>
                              </c:choose>
                            </dd>
                          </div>
                          <c:if test="${not empty order.deliveryAddress}">
                            <div>
                              <dt>Delivery Address</dt>
                              <dd>${order.deliveryAddress}</dd>
                            </div>
                          </c:if>
                          <c:if test="${not empty order.notes}">
                            <div>
                              <dt>Notes</dt>
                              <dd>${order.notes}</dd>
                            </div>
                          </c:if>
                        </dl>
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
              <span class="material-symbols-outlined">payments</span>
              <p>No payment records found.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div><!-- /admin-main -->
</div><!-- /admin-shell -->

<script>
  /**
   * Toggle inline detail row for a billing entry.
   * @param {string} detailId - The id of the detail <tr>
   * @param {HTMLElement} btn  - The button that was clicked
   */
  function toggleDetail(detailId, btn) {
    var detailRow = document.getElementById(detailId);
    if (!detailRow) return;

    var isOpen = detailRow.classList.contains('open');
    detailRow.classList.toggle('open', !isOpen);

    var icon = btn.querySelector('.material-symbols-outlined');
    if (icon) icon.textContent = isOpen ? 'expand_more' : 'expand_less';

    btn.setAttribute('aria-expanded', String(!isOpen));
    btn.querySelector('span + span') && (btn.lastChild.textContent = isOpen ? ' View Details' : ' Hide Details');
  }

  /** Filter billing table rows by order ID or customer */
  function filterBilling() {
    var query = document.getElementById('billingSearch').value.toLowerCase().trim();
    var rows  = document.querySelectorAll('.billing-row');
    var visible = 0;
    rows.forEach(function(row) {
      var orderId  = (row.dataset.orderid  || '').toLowerCase();
      var customer = (row.dataset.customer || '').toLowerCase();
      var match    = orderId.includes(query) || customer.includes(query);
      row.style.display = match ? '' : 'none';

      // Also hide/show the associated detail row
      var detailId  = 'detail-' + row.dataset.orderid;
      var detailRow = document.getElementById(detailId);
      if (detailRow) detailRow.style.display = match ? '' : 'none';

      if (match) visible++;
    });
    var countEl = document.getElementById('billingCount');
    if (countEl) countEl.textContent = visible + ' record(s) shown';
  }

  document.addEventListener('DOMContentLoaded', function() {
    var rows = document.querySelectorAll('.billing-row');
    var countEl = document.getElementById('billingCount');
    if (countEl) countEl.textContent = rows.length + ' record(s)';
  });
</script>

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
  </div>
  <form id="paidForm" method="post" action="${pageContext.request.contextPath}/admin/billing">
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
  function openPaidModal(orderId, amount) {
    document.getElementById('paidOrderId').value = orderId;
    document.getElementById('paidModalSubtitle').textContent = 'Order #' + orderId + ' — ' + amount;
    document.getElementById('paidTxnId').value = '';
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
    document.getElementById('paidMethodHidden').value = document.getElementById('paidMethod').value;
    document.getElementById('paidTxnHidden').value    = document.getElementById('paidTxnId').value.trim() || ('ADMIN-' + Date.now());
    document.getElementById('paidForm').submit();
  }
  document.addEventListener('keydown', function(e){ if(e.key==='Escape') closePaidModal(); });
</script>

</body>
</html>

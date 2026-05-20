<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="java.util.*,java.math.BigDecimal" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Billing</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin.css">
  <style>
    /* ── Bill / Invoice card ── */
    .bill-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
      gap: 20px;
    }
    .bill-card {
      background: #ffffff;
      border: 1px solid rgba(131,116,111,.15);
      border-radius: 18px;
      overflow: hidden;
      box-shadow: 0 4px 16px rgba(50,23,13,.06);
      display: flex;
      flex-direction: column;
      transition: box-shadow .2s;
    }
    .bill-card:hover { box-shadow: 0 8px 28px rgba(50,23,13,.12); }

    /* Coloured top stripe by status */
    .bill-card-stripe {
      height: 5px;
      background: #d5c3bd;
    }
    .bill-card-stripe.paid      { background: linear-gradient(90deg,#2f7d32,#4caf50); }
    .bill-card-stripe.completed { background: linear-gradient(90deg,#2f7d32,#4caf50); }
    .bill-card-stripe.pending   { background: linear-gradient(90deg,#f0bd8b,#e8a040); }
    .bill-card-stripe.cancelled { background: linear-gradient(90deg,#ba1a1a,#e53935); }

    .bill-card-head {
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      padding: 18px 20px 12px;
      gap: 12px;
    }
    .bill-invoice-no {
      font-family: 'Noto Serif', serif;
      font-size: 18px;
      font-weight: 700;
      color: #32170d;
    }
    .bill-date {
      font-size: 12px;
      color: #504440;
      margin-top: 3px;
    }

    .bill-divider {
      height: 1px;
      background: rgba(131,116,111,.1);
      margin: 0 20px;
    }

    .bill-body { padding: 14px 20px; flex: 1; }

    .bill-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 6px 0;
      font-size: 13px;
      color: #504440;
    }
    .bill-row strong { color: #271814; font-weight: 700; }
    .bill-row.total-row {
      padding-top: 10px;
      margin-top: 6px;
      border-top: 1.5px dashed rgba(131,116,111,.25);
      font-size: 16px;
      font-weight: 700;
      color: #32170d;
    }
    .bill-row.total-row span:last-child {
      font-family: 'Noto Serif', serif;
      font-size: 20px;
    }

    .bill-items-toggle {
      font-size: 12px;
      font-weight: 700;
      color: #7d562d;
      cursor: pointer;
      background: none;
      border: none;
      padding: 0;
      font-family: inherit;
      display: flex;
      align-items: center;
      gap: 4px;
      margin-top: 8px;
    }
    .bill-items-detail {
      display: none;
      background: #fff9f7;
      border-radius: 10px;
      padding: 10px 12px;
      margin-top: 8px;
      font-size: 12px;
      color: #504440;
      line-height: 1.6;
      word-break: break-word;
    }
    .bill-items-detail.open { display: block; }

    .bill-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 8px;
      padding: 12px 20px 16px;
      flex-wrap: wrap;
    }

    /* Print styles */
    @media print {
      .admin-sidebar, .admin-topbar, .page-header,
      .stats-grid, .search-bar, .card-header .btn-primary,
      .bill-footer button, .paid-overlay, .paid-modal { display: none !important; }
      .admin-main { margin-left: 0 !important; }
      .bill-card { break-inside: avoid; box-shadow: none; border: 1px solid #ccc; }
    }

    /* Mark-as-Paid modal */
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
    .paid-modal-foot .btn-cancel  { flex:1; padding:12px; border:1.5px solid #d5c3bd; border-radius:10px; background:transparent; color:#504440; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit; }
    .paid-modal-foot .btn-confirm { flex:2; display:inline-flex; align-items:center; justify-content:center; gap:8px; padding:12px; border:none; border-radius:10px; background:#2f7d32; color:#fff; font-size:14px; font-weight:700; cursor:pointer; font-family:inherit; }
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
      <a href="${pageContext.request.contextPath}/admin/menu"      class="nav-item"><span class="material-symbols-outlined">restaurant_menu</span>Menu Management</a>
      <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item"><span class="material-symbols-outlined">people</span>Customers</a>
      <a href="${pageContext.request.contextPath}/admin/inventory" class="nav-item"><span class="material-symbols-outlined">inventory_2</span>Inventory</a>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item"><span class="material-symbols-outlined">bar_chart</span>Analytics</a>
      <a href="${pageContext.request.contextPath}/admin/billing"   class="nav-item active"><span class="material-symbols-outlined">payments</span>Billing</a>
    </nav>
    <div class="sidebar-footer">
      <button class="nav-item logout-trigger" 
              data-logout-url="${pageContext.request.contextPath}/logout"
              style="background:none;border:none;cursor:pointer;width:100%;text-align:left;color:inherit;font-family:inherit;font-size:inherit;">
          <span class="material-symbols-outlined">logout</span>Logout
      </button>
    </div>
  </aside>

  <%-- ── Main ── --%>
  <div class="admin-main">
    <header class="admin-topbar">
      <h1 class="topbar-title">Billing &amp; Invoices</h1>
      <div class="topbar-actions">
        <span class="topbar-welcome">Welcome, Admin</span>
        <button onclick="window.print()" class="btn-secondary btn-sm">
          <span class="material-symbols-outlined" style="font-size:16px;">print</span>Print
        </button>
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
        <h1>Billing &amp; Invoices</h1>
        <p>All generated bills — each card is one invoice. Mark pending payments as paid directly from here.</p>
      </div>

      <%-- ── Stats ── --%>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon revenue"><span class="material-symbols-outlined">payments</span></div>
          <p class="stat-value">Rs. ${not empty totalRevenue ? totalRevenue : '0.00'}</p>
          <p class="stat-label">Total Revenue</p>
        </div>
        <div class="stat-card">
          <div class="stat-icon" style="background:rgba(47,125,50,.1);color:#2f7d32;">
            <span class="material-symbols-outlined">check_circle</span>
          </div>
          <p class="stat-value">${not empty paidOrders ? paidOrders : 0}</p>
          <p class="stat-label">Paid Bills</p>
        </div>
        <div class="stat-card">
          <div class="stat-icon orders"><span class="material-symbols-outlined">pending</span></div>
          <p class="stat-value">${not empty pendingOrders ? pendingOrders : 0}</p>
          <p class="stat-label">Pending Bills</p>
        </div>
        <div class="stat-card">
          <div class="stat-icon" style="background:rgba(186,26,26,.1);color:#ba1a1a;">
            <span class="material-symbols-outlined">cancel</span>
          </div>
          <p class="stat-value">${not empty cancelledOrders ? cancelledOrders : 0}</p>
          <p class="stat-label">Cancelled</p>
        </div>
      </div>

      <%-- ── Filter + Search ── --%>
      <div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:20px;align-items:center;">
        <button class="filter-tab active" onclick="filterBills('all',this)">All Bills</button>
        <button class="filter-tab" onclick="filterBills('pending',this)">Pending</button>
        <button class="filter-tab" onclick="filterBills('completed',this)">Paid</button>
        <button class="filter-tab" onclick="filterBills('cancelled',this)">Cancelled</button>
        <div class="search-bar" style="flex:1;min-width:200px;margin-bottom:0;">
          <span class="material-symbols-outlined">search</span>
          <input type="text" id="billSearch" placeholder="Search by bill # or customer…" oninput="searchBills()">
        </div>
        <span id="billCount" style="font-size:13px;color:#504440;font-weight:600;white-space:nowrap;"></span>
      </div>

      <%-- ── Bill Cards Grid ── --%>
      <c:choose>
        <c:when test="${not empty orders}">
          <div class="bill-grid" id="billGrid">
            <c:forEach var="order" items="${orders}">
              <div class="bill-card"
                   data-status="${order.status}"
                   data-orderid="${order.orderId}"
                   data-customer="${order.userId}">

                <%-- Coloured stripe --%>
                <div class="bill-card-stripe ${order.status}"></div>

                <%-- Header --%>
                <div class="bill-card-head">
                  <div>
                    <div class="bill-invoice-no">Invoice #${order.orderId}</div>
                    <div class="bill-date">${order.orderDate}</div>
                  </div>
                  <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                </div>

                <div class="bill-divider"></div>

                <%-- Body ── billing details --%>
                <div class="bill-body">
                  <div class="bill-row">
                    <span>Customer</span>
                    <strong>User #${order.userId}</strong>
                  </div>
                  <div class="bill-row">
                    <span>Payment Method</span>
                    <strong>
                      <c:choose>
                        <c:when test="${not empty order.payment}">
                          <%-- Extract method from JSON string simply --%>
                          <c:set var="pm" value="${order.payment}"/>
                          <c:choose>
                            <c:when test="${pm.contains('khalti')}">Khalti</c:when>
                            <c:when test="${pm.contains('cod')}">Cash on Delivery</c:when>
                            <c:when test="${pm.contains('fonepay')}">Fonepay</c:when>
                            <c:when test="${pm.contains('esewa')}">eSewa</c:when>
                            <c:when test="${pm.contains('cash')}">Cash</c:when>
                            <c:otherwise>Online</c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise>—</c:otherwise>
                      </c:choose>
                    </strong>
                  </div>
                  <div class="bill-row">
                    <span>Delivery Fee</span>
                    <strong>Rs. 50</strong>
                  </div>

                  <div class="bill-row total-row">
                    <span>Total</span>
                    <span>Rs. ${order.totalAmount}</span>
                  </div>

                  <%-- Items toggle --%>
                  <button class="bill-items-toggle" type="button"
                          onclick="toggleItems('items-${order.orderId}', this)">
                    <span class="material-symbols-outlined" style="font-size:14px;">expand_more</span>
                    View order items
                  </button>
                  <div class="bill-items-detail" id="items-${order.orderId}">
                    <c:choose>
                      <c:when test="${not empty order.items}">${order.items}</c:when>
                      <c:otherwise>No item details recorded.</c:otherwise>
                    </c:choose>
                  </div>
                </div>

                <div class="bill-divider"></div>

                <%-- Footer actions --%>
                <div class="bill-footer">
                  <%-- Status update --%>
                  <form method="post" action="${pageContext.request.contextPath}/admin/orders"
                        style="display:flex;gap:6px;align-items:center;">
                    <input type="hidden" name="action"  value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <select name="status" class="form-control"
                            style="padding:6px 28px 6px 10px;font-size:12px;width:auto;">
                      <option value="pending"   ${order.status=='pending'   ? 'selected':''}> Pending</option>
                      <option value="completed" ${order.status=='completed' ? 'selected':''}> Completed</option>
                      <option value="cancelled" ${order.status=='cancelled' ? 'selected':''}> Cancelled</option>
                    </select>
                    <button type="submit" class="btn-primary btn-sm">Save</button>
                  </form>

                  <%-- Mark Paid (pending only) --%>
                  <c:if test="${order.status == 'pending'}">
                    <button type="button" class="btn-sm"
                            onclick="openPaidModal(${order.orderId}, 'Rs. ${order.totalAmount}')"
                            style="background:rgba(47,125,50,.12);color:#246328;border:none;padding:7px 12px;border-radius:8px;font-size:12px;font-weight:700;cursor:pointer;display:inline-flex;align-items:center;gap:5px;">
                      <span class="material-symbols-outlined" style="font-size:14px;">check_circle</span>
                      Mark Paid
                    </button>
                  </c:if>
                </div>

              </div><%-- /bill-card --%>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <span class="material-symbols-outlined">receipt_long</span>
            <p>No bills generated yet. Orders will appear here once customers check out.</p>
          </div>
        </c:otherwise>
      </c:choose>

    </main>
  </div>
</div>

<%-- ── Mark-as-Paid Modal ── --%>
<div id="paidOverlay" class="paid-overlay" onclick="closePaidModal()"></div>
<div id="paidModal" class="paid-modal" role="dialog" aria-modal="true">
  <div class="paid-modal-head">
    <span class="material-symbols-outlined" style="font-size:36px;display:block;margin-bottom:8px;">payments</span>
    <h2>Mark Bill as Paid</h2>
    <p id="paidModalSubtitle">Confirm payment receipt for this invoice.</p>
  </div>
  <div class="paid-modal-body">
    <div class="form-group">
      <label class="form-label">Payment Method</label>
      <select id="paidMethod" class="form-control">
        <option value="cash">Cash on Delivery (collected)</option>
        <option value="khalti">Khalti</option>
        <option value="fonepay">Fonepay</option>
        <option value="esewa">eSewa</option>
        <option value="bank_transfer">Bank Transfer</option>
        <option value="other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label class="form-label">Transaction / Reference ID
        <span style="font-weight:400;text-transform:none;">(optional)</span>
      </label>
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
  /* ── Filter tabs ── */
  var currentFilter = 'all';
  function filterBills(status, btn) {
    currentFilter = status;
    document.querySelectorAll('.filter-tab').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');
    applyFilters();
  }

  /* ── Search ── */
  function searchBills() { applyFilters(); }

  function applyFilters() {
    var query   = (document.getElementById('billSearch').value || '').toLowerCase().trim();
    var cards   = document.querySelectorAll('.bill-card');
    var visible = 0;
    cards.forEach(function(card) {
      var status   = (card.dataset.status   || '').toLowerCase();
      var orderId  = (card.dataset.orderid  || '').toLowerCase();
      var customer = (card.dataset.customer || '').toLowerCase();
      var matchStatus = currentFilter === 'all' || status === currentFilter;
      var matchSearch = !query || orderId.includes(query) || customer.includes(query);
      var show = matchStatus && matchSearch;
      card.style.display = show ? '' : 'none';
      if (show) visible++;
    });
    var el = document.getElementById('billCount');
    if (el) el.textContent = visible + ' bill(s)';
  }

  /* ── Items toggle ── */
  function toggleItems(id, btn) {
    var el   = document.getElementById(id);
    var open = el.classList.toggle('open');
    var icon = btn.querySelector('.material-symbols-outlined');
    if (icon) icon.textContent = open ? 'expand_less' : 'expand_more';
    btn.childNodes[1] && (btn.childNodes[1].textContent = open ? ' Hide items' : ' View order items');
  }

  /* ── Mark-as-Paid modal ── */
  function openPaidModal(orderId, amount) {
    document.getElementById('paidOrderId').value = orderId;
    document.getElementById('paidModalSubtitle').textContent = 'Invoice #' + orderId + ' — ' + amount;
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

  /* ── Init count ── */
  document.addEventListener('DOMContentLoaded', function() {
    var cards = document.querySelectorAll('.bill-card');
    var el    = document.getElementById('billCount');
    if (el) el.textContent = cards.length + ' bill(s)';
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

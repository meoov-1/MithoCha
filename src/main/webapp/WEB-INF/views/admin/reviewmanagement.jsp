<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List,com.mithocha.model.Review" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MithoCha Admin — Reviews</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,600;0,700;1,400&family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin.css">
</head>
<body>

<div class="admin-shell">

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
      <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-item active">
        <span class="material-symbols-outlined">rate_review</span>
        Reviews
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

  </aside>

  <div class="admin-main">

    <header class="admin-topbar">
      <h1 class="topbar-title">Reviews</h1>
      <div class="topbar-actions">
        <span class="topbar-welcome">Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="btn-secondary btn-sm">
          <span class="material-symbols-outlined" style="font-size:16px;">logout</span>
          Logout
        </a>
      </div>
    </header>

    <main class="admin-content">

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

      <div class="admin-card">
        <div class="card-header">
          <h2 class="card-title">Customer Reviews</h2>
          <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-secondary btn-sm">Back to Dashboard</a>
        </div>
        <div class="table-wrapper">
          <c:choose>
            <c:when test="${not empty reviews}">
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>Review</th>
                    <th>User</th>
                    <th>Product</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="review" items="${reviews}">
                    <tr>
                      <td><strong>#${review.reviewId}</strong></td>
                      <td>${review.userId}</td>
                      <td>${review.productId}</td>
                      <td>${review.rating}</td>
                      <td><c:out value="${review.comment}" default="-"/></td>
                      <td>${review.createdAt}</td>
                      <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/reviews" style="display:inline-block;">
                          <input type="hidden" name="action" value="delete" />
                          <input type="hidden" name="reviewId" value="${review.reviewId}" />
                          <button type="submit" class="btn-link" onclick="return confirm('Delete review #${review.reviewId}?');">
                            Delete
                          </button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <span class="material-symbols-outlined">rate_review</span>
                <p>No reviews have been submitted yet.</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/logout-popup.js"></script>
</body>
</html>

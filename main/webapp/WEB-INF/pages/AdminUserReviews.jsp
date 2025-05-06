<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Game Reviews</title>

  <!-- External Styles and Fonts -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
  
  <!-- Local CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminUserReviews.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
</head>
<body>

<jsp:include page="Header.jsp" />

<h1 class="main-header">All User Reviews</h1>

<div class="container">
  <!-- Header Row -->
  <div class="header">
    <div>Reviews</div>
    <div style="text-align: center;">Game</div>
    <div style="text-align: center;">Date Posted</div>
    <div style="text-align: center;">Edit</div>
  </div>

  <!-- Review List -->
  <div id="review-list">
    <c:choose>
      <c:when test="${not empty reviews}">
        <c:forEach var="review" items="${reviews}">
          <div class="review-item" data-review-id="${review.reviewId}">
            <div>
              <div class="user-info">
                <div class="user-details">
                  <p class="username">User ID: ${review.userId}</p>
                  <p class="comment">${review.reviewText}</p>
                </div>
              </div>
            </div>
            <div class="game">
              <a href="${pageContext.request.contextPath}/game/${review.gameId}">Game ID: ${review.gameId}</a>
            </div>
            <div class="date">
              <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" />
            </div>
            <div class="edit">
              <form method="post" action="${pageContext.request.contextPath}/admin/reviews" class="delete-form">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="reviewId" value="${review.reviewId}">
                <button type="submit" class="remove-btn">Remove</button>
              </form>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="no-reviews">No reviews available at the moment.</div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Pagination -->
  <div class="pages">
    <c:if test="${currentPage > 1}">
      <a href="${pageContext.request.contextPath}/admin/reviews?page=${currentPage - 1}">
        <button id="prevPage"><i class="fa fa-arrow-left" aria-hidden="true"></i> Previous Page</button>
      </a>
    </c:if>
    <div class="PageNumber">Page ${currentPage} of ${totalPages}</div>
    <c:if test="${currentPage < totalPages}">
      <a href="${pageContext.request.contextPath}/admin/reviews?page=${currentPage + 1}">
        <button id="nextPage">Next Page <i class="fa fa-arrow-right" aria-hidden="true"></i></button>
      </a>
    </c:if>
  </div>
</div>

<jsp:include page="Footer.jsp" />

<!-- JavaScript -->
<script>
  // Confirmation for delete action
  document.querySelectorAll('.delete-form').forEach(form => {
    form.addEventListener('submit', function(e) {
      if (!confirm('Are you sure you want to delete this review?')) {
        e.preventDefault();
      }
    });
  });
</script>

</body>
</html>
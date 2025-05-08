<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Game Reviews</title>
    <link rel="stylesheet" href="styles.css" />
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
      integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
      crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminUserReviews.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
  </head>
  <body>
    <jsp:include page="Header.jsp" />
    <c:if test="${not empty userReviews}">
	  <h1 class="main-header">${userReviews[0].username}'s Reviews</h1>
	</c:if>
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
		    <c:when test="${empty userReviews}">
		      <div style="text-align: center; font-size: 1.2em; padding: 20px;">You haven't posted any reviews yet.</div>
		    </c:when>
		    <c:otherwise>
		      <c:forEach var="review" items="${userReviews}">
		        <div class="review-item">
		          <div>
		            <div class="user-info">
		              <div class="user-details">
		                <p class="username">
						  <a href="${pageContext.request.contextPath}/User-Dashboard">${review.username}</a>
						</p>
		                <p class="comment">${review.reviewText}</p>
		              </div>
		            </div>
		          </div>
		          <div class="game">
					  <a href="${pageContext.request.contextPath}/Game?id=${review.gameId}">${review.gameTitle}</a>
					</div>
		          <div class="date">${review.reviewDate}</div>
		          <div class="edit">
					  <form method="post" action="${pageContext.request.contextPath}/My-Reviews">
					    <input type="hidden" name="reviewId" value="${review.reviewId}" />
					    <button type="submit" class="remove-btn">Remove</button>
					  </form>
					</div>
		        </div>
		      </c:forEach>
		    </c:otherwise>
		  </c:choose>
		</div>

    </div>
    <jsp:include page="Footer.jsp" />
    <script>
	  document.querySelectorAll('.remove-btn').forEach(button => {
	    button.addEventListener('click', function (e) {
	      if (!confirm('Are you sure you want to delete this review?')) {
	        e.preventDefault();
	      }
	    });
	  });
	</script>
  </body>
</html>

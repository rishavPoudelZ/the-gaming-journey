<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Game Reviews</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminUserReviews.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <h1 class="main-header">All User Reviews</h1>

    <c:if test="${not empty param.error}">
        <div class="error-message">
            Error: 
            <c:choose>
                <c:when test="${param.error eq 'delete_failed'}">Failed to delete review</c:when>
                <c:when test="${param.error eq 'invalid_id'}">Invalid review ID</c:when>
                <c:otherwise>System error occurred</c:otherwise>
            </c:choose>
        </div>
        
    </c:if>

    <c:if test="${not empty param.deleted}">
        <div class="success-message" id="successMessage" style="margin-left: 96px; margin-top: 10px; color:green;">Review deleted successfully</div>
        <script>
        // Automatically hide the success message after 2 seconds
        setTimeout(function () {
            var msg = document.getElementById("successMessage");
            if (msg) {
                msg.style.display = "none";
            }
        }, 2000); // 2000ms = 2 seconds
    </script>
    </c:if>

    <div class="container">
        <!-- Header Row -->
        <div class="header">
            <div>Reviews</div>
            <div style="text-align: center;">Game</div>
            <div style="text-align: center;">Date Posted</div>
            <div style="text-align: center;">Edit</div>
        </div>

        <!-- Dynamic Review List -->
        <div id="review-list">
            <c:forEach var="review" items="${reviews}">
                <div class="review-item">
                    <div>
                        <div class="user-info">
                            <div class="user-details">
                                <p class="username">${review.username}</p>
                                <p class="comment">${review.reviewText}</p>
                            </div>
                        </div>
                    </div>
                    <div class="game">
					  <a href="${pageContext.request.contextPath}/Game?gameId=${review.gameId}">
					    ${review.gameTitle}
					  </a>
					</div>
                    <div class="date">
                        <fmt:formatDate value="${review.reviewDate}" pattern="dd/MM/yyyy" />
                    </div>
                    <div class="edit">
                        <form method="post" action="${pageContext.request.contextPath}/Admin-User-Reviews">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="reviewId" value="${review.reviewId}" />
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty reviews}">
                <p style="text-align: center; padding: 20px;">No reviews available.</p>
            </c:if>
        </div>

        <!-- Pagination -->
        <div class="pages">
            <c:set var="prevPage" value="${currentPage - 1}" />
            <c:set var="nextPage" value="${currentPage + 1}" />
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <a href="?page=${prevPage}" class="pagination-btn">
                        <i class="fa fa-arrow-left"></i> Previous Page
                    </a>
                </c:when>
                <c:otherwise>
                    <button class="pagination-btn" disabled><i class="fa fa-arrow-left"></i> Previous Page</button>
                </c:otherwise>
            </c:choose>

            <div class="PageNumber">Page ${currentPage} of ${totalPages}</div>

            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <a href="?page=${nextPage}" class="pagination-btn">
                        Next Page <i class="fa fa-arrow-right"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <button class="pagination-btn" disabled>Next Page <i class="fa fa-arrow-right"></i></button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

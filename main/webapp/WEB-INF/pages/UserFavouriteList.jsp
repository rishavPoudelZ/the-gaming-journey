<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Favorite List</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" tags="text/css" href="../Css/FavorateP.css">
        <link rel="Image" href="../picture/p.jpg">
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserFavouriteList.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    </head>
    <body>
        <jsp:include page="Header.jsp" />
        
        <div class="favorite-list-container">
            <h2 class="favorite-list-title">My Favorite List</h2>
            <div class="table-container">
                <div class="favorite-list-table">
                    <div class="table-header">
                        <div class="number-header">#</div>
                        <div class="image-header">Image</div>
                        <div class="title-header">Game Title</div>
                        <div class="rating-header">Rating</div>
                        <div class="actions-header">Actions</div>
                    </div>
                    <div class="table-body">
					    <c:if test="${not empty errorMessage}">
						    <div id="error-message" style="color: red; text-align: center; font-size: 1.2em; margin: 20px;">
						        ${errorMessage}
						    </div>
						    <script>
						        // Auto-hide the error message after 5 seconds
						        setTimeout(function() {
						            var errorMsg = document.getElementById("error-message");
						            if (errorMsg) {
						                errorMsg.style.display = 'none';
						            }
						        }, 5000);
						    </script>
						</c:if>

					
					    <c:choose>
					        <c:when test="${empty favouriteGames}">
					            <div style="text-align: center; font-size: 2em; padding: 40px;">
					                No favourite games found.
					            </div>
					        </c:when>
					        <c:otherwise>
					            <c:forEach var="game" items="${favouriteGames}" varStatus="status">
					                <div class="table-row">
					                    <div class="cell-number">${status.index + 1}</div>
					                    <div class="cell-image">
					                        <img src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" alt="${game.title}">
					                    </div>
					                    <div class="cell-title">
					                    	<a href="${pageContext.request.contextPath}/Game?id=${game.gameId}">${game.title}</a>
					                        <br>
					                        <sub>${game.developer} ${game.releaseDate}</sub>
					                    </div>
					                    <div class="cell-rating">
					                        <span>${game.avgRating}</span>
					                    </div>
					                    <div class="cell-actions">
					                        <form method="post" action="${pageContext.request.contextPath}/Favourites/remove">
					                            <input type="hidden" name="gameId" value="${game.gameId}" />
					                            <button type="submit" class="delete-button">Remove</button>
					                        </form>
					                    </div>
					                </div>
					            </c:forEach>
					        </c:otherwise>
					    </c:choose>
					</div>

                    
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp" />
    </body>
</html>

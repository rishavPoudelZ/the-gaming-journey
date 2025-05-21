<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Favorite List</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../Css/AdminP.css">
        <link rel="Image" href="../picture/p.jpg">
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminGamelist.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    </head>
    <body>
        <div class="favorite-list-container">
            <h2 class="favorite-list-title">All Games List</h2>
            <div class="table-container">
                <div class="favorite-list-table">
                    <div class="table-header">
                        <div class="number-header">#</div>
                        <div class="image-header">Image</div>
                        <div class="title-header">Game Name</div>
                        <div class="rating-header">Rating</div>
                        <div class="tags-header">Genre</div>
                        <div class="actions-header">Actions</div>
                    </div>
                    <div class="table-body">
					    <c:forEach var="game" items="${games}" varStatus="status">
					        <div class="table-row">
					            <div class="cell-number">${status.index + 1}</div>
					            <div class="cell-image">
					                <img src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" alt="${game.title}">
					            </div>
					            <div class="cell-title">
					                <a href="${pageContext.request.contextPath}/Game?id=${game.gameId}">${game.title}</a><br>
					                <sub>${game.developer} ${game.releaseDate}</sub>
					            </div>
					            <div class="cell-rating">
					                ${game.avgRating}
					            </div>
					            <div class="cell-tags">
					                <c:forEach var="genre" items="${game.genres}">
					                    ${genre}<c:if test="${!genre.equals(game.genres[game.genres.size()-1])}">, </c:if>
					                </c:forEach>
					            </div>
					            <div class="cell-actions">
					                <a href="${pageContext.request.contextPath}/Edit-Game?id=${game.gameId}" class="edit-button">Edit</a>
					                <form method="post" action="${pageContext.request.contextPath}/Admin-Game-List" onsubmit="return confirm('Are you sure you want to delete this game?');">
									    <input type="hidden" name="gameId" value="${game.gameId}" />
									    <input type="hidden" name="action" value="delete" />
									    <button type="submit" class="delete-button">Delete</button>
									</form>
					            </div>
					        </div>
					    </c:forEach>
					</div>
                </div>
            </div>
        </body>
    </html>

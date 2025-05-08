<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>${selectedGenre != null ? selectedGenre : 'All Games'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/GamesPage.css">
    
    <style>
      /* CSS for hover effect */
      .game-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer;
      }

      .game-card:hover {
        transform: scale(1.05); /* Slightly enlarge the card */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add a shadow effect */
      }
    </style>
  </head>
  <body>
    <jsp:include page="Header.jsp" />
    
    <section class="genre">
      <p>Home | ${selectedGenre != null ? selectedGenre : 'All Games'}</p>
      <form action="${pageContext.request.contextPath}/Games" method="get">
        <label for="genre">Genre:</label>
        <select id="genre" name="genre" required>
          <c:forEach var="genre" items="${genresList}">
            <option value="${genre.name}" ${selectedGenre == genre.name ? 'selected' : ''}>${genre.name}</option>
          </c:forEach>
        </select>
        <button type="submit">Filter</button>
      </form>
    </section>

    <main class="game-grid">
	  <c:choose>
	    <c:when test="${empty gamesList}">
	      <div style="grid-column: 1 / -1; text-align: center; font-size: 2em; padding: 50px 0;">
	        No games found
	      </div>
	    </c:when>
	    <c:otherwise>
	      <c:forEach var="game" items="${gamesList}">
	        <div class="game-card" style="text-align: center; cursor: pointer;"
	             onclick="window.location.href='${pageContext.request.contextPath}/Game?id=${game.gameId}'">
	          <img src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" alt="${game.title}">
	          <h3>${game.title}</h3>
	          <p>${game.description}</p>
	          <div class="rating">⭐⭐⭐⭐⭐ ${game.avgRating}</div>
	        </div>
	      </c:forEach>
	    </c:otherwise>
	  </c:choose>
	</main>


    <jsp:include page="Footer.jsp" />
  </body>
</html>

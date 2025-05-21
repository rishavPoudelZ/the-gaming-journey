<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thegamingjourney.model.Game" %>
<%@ page import="com.thegamingjourney.model.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="com.thegamingjourney.service.GamePageService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
    Game game = (Game) request.getAttribute("game");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>


<%
    String gameTitleUnderscored = game.getTitle().replace(" ", "_");
    String imageFolderPath = application.getRealPath("/assets/gamesImages/" + gameTitleUnderscored);
    File folder = new File(imageFolderPath);
    File[] imageFilesArray = folder.listFiles((dir, name) -> name.matches(gameTitleUnderscored + "_image\\d+\\.jpg"));

    // Sort by image number (image1.jpg, image2.jpg, etc.)
    java.util.Arrays.sort(imageFilesArray, (f1, f2) -> {
        String n1 = f1.getName().replaceAll("\\D", "");
        String n2 = f2.getName().replaceAll("\\D", "");
        return Integer.compare(Integer.parseInt(n1), Integer.parseInt(n2));
    });
%>

<%
    int userId = (int) session.getAttribute("userId");
    boolean isFavorite = new GamePageService().isFavorite(userId, game.getGameId());
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Red Dead Redemption</title>
    <link rel="stylesheet" href="specificstyle.css">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
      integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
      crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/GamePage.css">
        <style>
		        .star-rating form {
				  margin: 0;
				  padding: 0;
				}
				
				.star-button {
				  background: none;
				  border: none;
				  font-size: 2em;
				  color: #ccc;
				  cursor: pointer;
				  padding: 0 5px;
				}
				
				.star-button:hover,
				.star-button:focus {
				  color: gold;
				  outline: none;
				}
		</style>
  </head>
  <body>
    <jsp:include page="Header.jsp" />
    <div class="container">

      <!-- Banner (Always first image) -->
		<div class="banner">
		  <img id="main-image" src="${pageContext.request.contextPath}/assets/gamesImages/<%= gameTitleUnderscored %>/<%= imageFilesArray[0].getName() %>" alt="Game Banner">
		  <div class="banner-arrows">
		    <i class="fa fa-angle-left" onclick="changeImage(-1)"></i>
		    <i class="fa fa-angle-right" onclick="changeImage(1)"></i>
		  </div>
		</div>
		
		<div class="gallery-container">
		  <div class="gallery">
		    <% for (int i = 0; i < imageFilesArray.length; i++) { %>
		      <img class="thumbnail" src="${pageContext.request.contextPath}/assets/gamesImages/<%= gameTitleUnderscored %>/<%= imageFilesArray[i].getName() %>" onclick="setMainImage(<%= i %>)">
		    <% } %>
		  </div>
		</div>

      <div class="game-header">
	    <h1><%= game.getTitle() %></h1>
	    <div class="rating">
	      <span>★ ★ ★ ★ ★</span>
	      <span class="score"><%= game.getAvgRating() %></span>
	    </div>
	  </div>
	  
	  <%
		    Integer userRating = (Integer) request.getAttribute("userRating");
		    if (userRating == null) userRating = 0;
		%>

      <div class="interactions">
        <button id="favorite"  class="Favorite">
		    <%= isFavorite ? "❤️ Remove from Favorites" : "🤍 Add to Favorites" %>
		</button>
        <p>Add your Rating</p>
        <div class="star-rating">
		  <% for (int i = 5; i >= 1; i--) { %>
		    <form method="post" action="<%= request.getContextPath() %>/RatingController" style="display:inline;">
		      <input type="hidden" name="gameId" value="<%= game.getGameId() %>">
		      <input type="hidden" name="ratingValue" value="<%= i %>">
		      <button type="submit" title="<%= i %> star" class="star-button" style="color: <%= userRating >= i ? "gold" : "#ccc" %>;">★</button>
		    </form>
		  <% } %>
		</div>


      </div>

	  <div class="info-section">
		    <div class="description">
		      <h3>Description:</h3>
		      <p><%= game.getDescription() %></p>
		      <button class="mature">Rated <%= game.getAgeRestriction() %></button>
		    </div>
		
		    <div class="meta">
		      <p><strong>Developer:</strong> <%= game.getDeveloper() %></p>
		      <p><strong>Release Date:</strong> <%= game.getReleaseDate() %></p>
		      <p><strong>Genres:</strong>
		        <%= String.join(", ", game.getGenres()) %>
		      </p>
		      <p><strong>Platforms:</strong>
		        <%= String.join(", ", game.getPlatforms()) %>
		      </p>
		    </div>
		  </div>
		
		  <div class="reviews-header">
		    <h3>Reviews</h3>
		    
		  </div>
		
		  	<form action="Game" method="post" class="add-review">
			  <div class="avatar"></div>
			  <textarea name="reviewText" placeholder="Add a review..." required></textarea>
			  <input type="hidden" name="gameId" value="${game.gameId}" />
			  <input type="hidden" name="action" value="addReview" />
			  <button type="submit">Post</button>
			</form>

		
		  <% if (reviews != null && !reviews.isEmpty()) {
		       int index = 0;
		       for (Review review : reviews) { %>
		    <div class="review-entry">
		      <div class="avatar"></div>
		      <div class="review-text">
		        <p class="username"><%= review.getUsername() %></p>
		        <p><%= review.getReviewText() %></p>
		      </div>
		      
		    </div>
		  <% index++; } } else { %>
		    <p>No reviews yet. Be the first to leave one!</p>
		  <% } %>
	</div>
	
	<jsp:include page="Footer.jsp" />
	
    <script>

    const imageFiles = [
        <% for (int i = 0; i < imageFilesArray.length; i++) { %>
          "<%= imageFilesArray[i].getName() %>"<%= i < imageFilesArray.length - 1 ? "," : "" %>
        <% } %>
      ];
      const basePath = "<%= request.getContextPath() %>/assets/gamesImages/<%= gameTitleUnderscored %>/";
      let currentIndex = 0;

      function setMainImage(index) {
        currentIndex = index;
        document.getElementById('main-image').src = basePath + imageFiles[index];
      }

      function changeImage(direction) {
        currentIndex += direction;
        if (currentIndex < 0) currentIndex = imageFiles.length - 1;
        if (currentIndex >= imageFiles.length) currentIndex = 0;
        setMainImage(currentIndex);
      }
    
    // Handles toggling the 'Add to Favorites' button
    const favorite = document.getElementById('favorite');
	let isFavorite = favorite.innerHTML.includes("Remove");
	
	favorite.addEventListener('click', () => {
	  fetch('<%= request.getContextPath() %>/Favourite', {
	    method: 'POST',
	    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	    body: 'gameId=<%= game.getGameId() %>'
	  })
	  .then(res => res.text())
	  .then(message => {
	    isFavorite = !isFavorite;
	    favorite.innerHTML = isFavorite ? '❤️ Remove from Favorites' : '🤍 Add to Favorites';
	    console.log(message);
	  })
	  .catch(error => console.error(error));
	});


    // Implements the star rating functionality
    const stars = document.querySelectorAll('.star-rating label'); // Targeting the labels now
    let currentRating = 0;

    stars.forEach((star, index) => {
      star.addEventListener('click', () => {
        currentRating = index + 1;
        updateStars(currentRating);
        console.log(`User rated: ${currentRating} stars`);
      });

      star.addEventListener('mouseover', () => {
        updateStars(index + 1);
      });

      star.addEventListener('mouseout', () => {
        updateStars(currentRating);
      });
    });

    function updateStars(rating) {
      stars.forEach((star, index) => {
        if (index < rating) {
          star.classList.add('selected');
        } else {
          star.classList.remove('selected');
        }
      });
    }

  </script>
  </body>
</html>
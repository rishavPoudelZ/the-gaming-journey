<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.thegamingjourney.model.Game" %>
<%@ page import="com.thegamingjourney.model.Review" %>
<%@ page import="java.util.List" %>
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
    File imageDir = new File(imageFolderPath);
    String[] imageFiles = imageDir.list((dir, name) -> name.matches(gameTitleUnderscored + "_image\\d+\\.jpg"));
    Arrays.sort(imageFiles); // Ensure image1, image2... order
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
  </head>
  <body>
    <jsp:include page="Header.jsp" />
    <div class="container">

      <!-- Banner (Always first image) -->
		<div class="banner">
		  <img id="main-banner" 
		       src="${pageContext.request.contextPath}/assets/gamesImages/<%= gameTitleUnderscored %>/<%= imageFiles != null && imageFiles.length > 0 ? imageFiles[0] : "default.jpg" %>" 
		       alt="${game.title}">
		  <div class="banner-arrows">
		    <i class="fa fa-angle-left" aria-hidden="true"></i>
		    <i class="fa fa-angle-right" aria-hidden="true"></i>
		  </div>
		</div>
		
		<!-- Gallery Thumbnails -->
		<div class="gallery-container">
		  <div class="gallery">
		    <% if (imageFiles != null) {
		         for (String fileName : imageFiles) {
		    %>
		      <img src="${pageContext.request.contextPath}/assets/gamesImages/<%= gameTitleUnderscored %>/<%= fileName %>" 
		           alt="<%= fileName %>" 
		           onclick="changeBannerImage(this)">
		    <%   }
		       } else { %>
		      <p>No screenshots available.</p>
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

      <div class="interactions">
        <p id="favorite" class="favorite">🤍 Add to Favorites</p>
        <p>Add your Rating</p>
        <div class="star-rating">
          <input type="radio" id="star5-3" name="rating-3" value="5" />
          <label for="star5-3" title="5 stars">★</label>
          <input type="radio" id="star4-3" name="rating-3" value="4" />
          <label for="star4-3" title="4 stars">★</label>
          <input type="radio" id="star3-3" name="rating-3" value="3" />
          <label for="star3-3" title="3 stars">★</label>
          <input type="radio" id="star2-3" name="rating-3" value="2" />
          <label for="star2-3" title="2 stars">★</label>
          <input type="radio" id="star1-3" name="rating-3" value="1" />
          <label for="star1-3" title="1 star">★</label>
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
		    <select>
		      <option>Recent</option>
		      <option>Oldest</option>
		      <option>Most Likes</option>
		      <option>Most Dislikes</option>
		    </select>
		  </div>
		
		  <div class="add-review">
		    <div class="avatar"></div>
		    <textarea placeholder="Add a review..." id="review-input"></textarea>
		    <button id="post-review-btn">Post</button>
		  </div>
		
		  <% if (reviews != null && !reviews.isEmpty()) {
		       int index = 0;
		       for (Review review : reviews) { %>
		    <div class="review-entry">
		      <div class="avatar"></div>
		      <div class="review-text">
		        <p class="username"><%= review.getUsername() %></p>
		        <p><%= review.getReviewText() %></p>
		      </div>
		      <div class="review-reactions">
		        <button class="reaction like" onclick="handleReaction(this, 'like', <%= index %>)">
		          👍 <span class="count" id="like-count-<%= index %>"><%= review.getLikes() %></span>
		        </button>
		        <button class="reaction dislike" onclick="handleReaction(this, 'dislike', <%= index %>)">
		          👎 <span class="count" id="dislike-count-<%= index %>"><%= review.getDislikes() %></span>
		        </button>
		      </div>
		    </div>
		  <% index++; } } else { %>
		    <p>No reviews yet. Be the first to leave one!</p>
		  <% } %>
	</div>
	
	<jsp:include page="Footer.jsp" />
    <script>
    
    function changeBannerImage(thumbnail) {
        const banner = document.getElementById('main-banner');
        banner.src = thumbnail.src;
      }
    
    // Handles toggling the 'Add to Favorites' button
    const favorite = document.getElementById('favorite');
    let isFavorite = false;

    favorite.addEventListener('click', () => {
      isFavorite = !isFavorite;
      favorite.classList.toggle('active');
      favorite.innerHTML = isFavorite ? '❤️ Remove from Favorites' : '🤍 Add to Favorites';
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

    // Enables posting user reviews
    document.getElementById("post-review-btn").addEventListener("click", () => {
      const reviewText = document.getElementById("review-input").value.trim();
      if (reviewText) {
        alert("Review Posted: " + reviewText); // Placeholder for actual submission
        document.getElementById("review-input").value = ""; // Clear the input field
      } else {
        alert("Please write something before posting.");
      }
    });

    // Manages the like and dislike reactions on reviews
    let reactionsState = [null, null]; // Tracks if a review is liked, disliked, or neither

    function handleReaction(button, type, reviewIndex) {
      const likeBtn = document.querySelector(`#like-count-${reviewIndex}`).parentNode;
      const dislikeBtn = document.querySelector(`#dislike-count-${reviewIndex}`).parentNode;
      const likeCount = document.getElementById(`like-count-${reviewIndex}`);
      const dislikeCount = document.getElementById(`dislike-count-${reviewIndex}`);

      if (reactionsState[reviewIndex] === type) {
        // Deselect the reaction
        button.classList.remove('active');
        reactionsState[reviewIndex] = null;
        if (type === 'like') likeCount.textContent = +likeCount.textContent - 1;
        else dislikeCount.textContent = +dislikeCount.textContent - 1;
      } else {
        // Select the current reaction and deselect the other if active
        if (reactionsState[reviewIndex] === 'like') {
          likeBtn.classList.remove('active');
          likeCount.textContent = +likeCount.textContent - 1;
        } else if (reactionsState[reviewIndex] === 'dislike') {
          dislikeBtn.classList.remove('active');
          dislikeCount.textContent = +dislikeCount.textContent - 1;
        }

        button.classList.add('active');
        if (type === 'like') likeCount.textContent = +likeCount.textContent + 1;
        else dislikeCount.textContent = +dislikeCount.textContent + 1;
        reactionsState[reviewIndex] = type;
      }
    }
  </script>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

      <div class="banner">
        <img src="${pageContext.request.contextPath}/assests/reddead0.jpg" alt="Game Banner">
        <div class="banner-arrows"><i class="fa fa-angle-left" aria-hidden="true"></i><i class="fa fa-angle-right" aria-hidden="true"></i></i>
        </div>
      </div>

      <div class="gallery-container">
        <div class="gallery">
          <img src="${pageContext.request.contextPath}/assests/reddead1.jpg" alt>
          <img src="${pageContext.request.contextPath}/assests/reddead2.jpg" alt>
          <img src="${pageContext.request.contextPath}/assests/reddead3.jpg" alt>
          <img src="${pageContext.request.contextPath}/assests/reddead4.jpg" alt>
          <img src="${pageContext.request.contextPath}/assests/reddead5.jpg" alt>
          <img src="${pageContext.request.contextPath}/assests/reddead6.jpg" alt>
        </div>
      </div>

      <div class="game-header">
        <h1>Red Dead Redemption</h1>
        <div class="rating">
          <span>★ ★ ★ ★ ★</span>
          <span class="score">4.7</span>
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
          <p>
            Red Dead Redemption is a 2010 action-adventure game developed by
            Rockstar San Diego and published by Rockstar Games. A successor to
            2004’s Red Dead Revolver, it is the second game in the Red Dead
            series. Red Dead Redemption is set during the decline of the
            American frontier in the year 1911.
          </p>
          <button class="mature">Rated Mature 18+</button>
        </div>

        <div class="meta">
          <p><strong>Developer:</strong> Rockstar Games</p>
          <p><strong>Release Date:</strong> May 18, 2010</p>
          <p><strong>Genre:</strong> Third person shooter</p>
          <p><strong>Platform:</strong> Playstation, Windows</p>
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

      <div class="review-entry">
        <div class="avatar"></div>
        <div class="review-text">
          <p class="username">UserName</p>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </div>
        <div class="review-reactions">
          <button class="reaction like"
            onclick="handleReaction(this, 'like', 0)">
            👍 <span class="count" id="like-count-0">12000</span>
          </button>
          <button class="reaction dislike"
            onclick="handleReaction(this, 'dislike', 0)">
            👎 <span class="count" id="dislike-count-0">1500</span>
          </button>
        </div>
      </div>

      <div class="review-entry">
        <div class="avatar"></div>
        <div class="review-text">
          <p class="username">UserName</p>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </div>
        <div class="review-reactions">
          <button class="reaction like"
            onclick="handleReaction(this, 'like', 1)">
            👍 <span class="count" id="like-count-1">10200</span>
          </button>
          <button class="reaction dislike"
            onclick="handleReaction(this, 'dislike', 1)">
            👎 <span class="count" id="dislike-count-1">700</span>
          </button>
        </div>
      </div>

    </div>
    <jsp:include page="Footer.jsp" />
    <script>
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
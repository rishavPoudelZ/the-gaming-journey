<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        <!-- Review Item 1 -->
        <div class="review-item">
          <div>
            <div class="user-info">
              <div class="user-details">
                <p class="username">UserName</p>
                <p class="comment">Lorem ipsum dolor sit amet, consectetur
                  adipiscing elit. Nullam vel odio vitae purus imperdiet
                  tristique sed ut turpis.</p>
              </div>
            </div>
          </div>
          <div class="game"><a href="arkham-knight.html">Arkham Knight</a></div>
          <div class="date">12/04/2025</div>
          <div class="edit"><button class="remove-btn">Remove</button></div>
        </div>

        <!-- Review Item 2 -->
        <div class="review-item">
          <div>
            <div class="user-info">
              <div class="user-details">
                <p class="username">AnotherUser</p>
                <p class="comment">Cyberpunk is a visually stunning and
                  ambitious game with some flaws, but I enjoyed it!</p>
              </div>
            </div>
          </div>
          <div class="game"><a href="cyberpunk.html">Cyberpunk</a></div>
          <div class="date">15/04/2025</div>
          <div class="edit"><button class="remove-btn">Remove</button></div>
        </div>

      </div>

      <!-- Select pages -->
      <div class="pages">
        <button id="prevPage"><i class="fa fa-arrow-left"
            aria-hidden="true"></i> Previous Page</button>
        <div class="PageNumber">Page 1 of 50</div>
        <button id="nextPage">Next Page <i class="fa fa-arrow-right"
            aria-hidden="true"></i></button>
      </div>
    </div>
    <jsp:include page="Footer.jsp" />

    <!-- JavaScript -->
    <script>
    document.querySelectorAll('.remove-btn').forEach(button => {
      button.addEventListener('click', () => {
        const reviewItem = button.closest('.review-item');
        reviewItem.remove();
      });
    });

    document.getElementById('prevPage').addEventListener('click', () => {
      alert('Previous page clicked!');
    });

    document.getElementById('nextPage').addEventListener('click', () => {
      alert('Next page clicked!');
    });
  </script>
  </body>
</html>

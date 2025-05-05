<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Adventure Games</title>
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
      integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
      crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/GamesPage.css">
  </head>
  <body>
    <jsp:include page="Header.jsp" />
    <section class="genrespecific">
      <p>Adventure</p> <br>
      <p class="genre-description">Focuses on exploration and narrative, with
        players navigating worlds to uncover stories</p>
    </section>
    <section class="genre">
      <p> Home | Adventure</p>

      <label for="subject">Genre:</label> <select id="subject"
        name="genre" required>
        <option value="Adventure"
          ${subject == 'Adventure' ? 'selected' : ''}>Adventure</option>
        <option value="Action"
          ${subject == 'Action' ? 'selected' : ''}>Action</option>
        <option value="Horror"
          ${subject == 'Horror' ? 'selected' : ''}>Horror</option>
        <option value="Action-Adventure"
          ${subject == 'Action-Adventure' ? 'selected' :
          ''}>Action-Adventure</option>
        <option value="Role-Playing"
          ${subject == 'Role-Playing' ? 'selected' : ''}>Role-Playing</option>
      </select>

    </section>

    <main class="game-grid">

      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Minecraft.jpeg" alt="Minecraft">
        <h3>Minecraft <button class="Favorite">&hearts;</button> </h3>
        <p>Explore your own unique worlds, survive the nights, enchant your
          armor and tools and defeat the Ender Gragon in the End.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <!--to add filled stars &#9733 and for empty stars &#9734-->
        <p class="reviews"> 19 Reviews</p>

      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Tron 2.0.jpeg" alt="Tron 2.0">
        <h3>Tron 2.0 <button class="Favorite">&hearts;</button></h3>
        <p>Dive into the grid and become the code. Tron 2.0 is not just a game,
          it is a neon-lit fight for digital survival</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">9 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/ThelastofuspartII.jpeg" alt="ThelastofuspartII">
        <h3>The Last of Us part II <button
            class="Favorite">&hearts;</button></h3>
        <p>In a world shattered by loss, vengeance cuts deeper than any scar.
          The Last of Us Part II is a brutal journey through love, pain, and
          everything in between.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/The Last of Us.jpeg" alt="The Last of Us">
        <h3>The Last of Us <button class="Favorite">&hearts;</button></h3>
        <p>When the world fell apart, they found something worth fighting for,
          The Last of Us is a haunting tale of survival, love, and what it means
          to be human</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Red Read Redemption II.jpeg"
          alt="Red Read Redemption II">
        <h3>Red Read Redemption <button class="Favorite">&hearts;</button></h3>
        <p>Outlaws to the end, Red Dead Redemption 2 rides through a dying
          frontier where loyalty is tested and freedom comes at a cost.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Split Fiction.jpeg" alt="Split Fiction">
        <h3>Split Fiction <button class="Favorite">&hearts;</button></h3>
        <p>When imagination turns into reality, only teamwork can rewrite the
          ending, Split Fiction is a genre-blending odyssey where sci-fi and
          fantasy collide in a wild, co-op adventure</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Elden Ring.jpeg" alt="Elden Ring">
        <h3>Elden Ring <button class="Favorite">&hearts;</button></h3>
        <p>Rise, Tarnished, and walk the path of grace, Elden Ring is a vast,
          unforgiving world where legends are born and destinies forged in fire
          and shadow.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Monkey Island.jpeg" alt="Monkey Island">
        <h3>Monkey Island <button class="Favorite">&hearts;</button></h3>
        <p>Set sail for sarcasm and swordplay. Monkey Island is where pirates
          bicker, puzzles baffle, and laughs are the real treasure.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/avowed.jpeg" alt="Avowed">
        <h3>Avowed <button class="Favorite">&hearts;</button></h3>
        <p>Swear your oath and shape the fate of Eora. Avowed plunges you into a
          world of magic, war, and the power that lies within your words.</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>
      <div class="game-card">
        <img src="${pageContext.request.contextPath}/assests/Slay The Spire.jpeg" alt="Slay The Spire">
        <h3>Slay The Spire <button class="Favorite">&hearts;</button></h3>
        <p>Build your deck, choose your path, and face the spire endless trials,
          Slay the Spire is a card-slinging, strategy-filled journey where every
          decision could be your last</p>
        <div class="rating">⭐⭐⭐⭐⭐</div>
        <p class="reviews">8 Reviews</p>
      </div>

    </main>
    <jsp:include page="Footer.jsp" />
  </body>
</html>

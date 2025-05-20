<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>The Gaming Journey - Add Games</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AddGame.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
</head>
<style> .checkbox-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 1rem;
}

.custom-checkbox {
    position: relative;
    display: inline-flex;
    align-items: center;
    padding-left: 28px;
    cursor: pointer;
    font-size: 14px;
    user-select: none;
    color: white;
}

.custom-checkbox input[type="checkbox"] {
    opacity: 0;
    position: absolute;
    left: 0;
    top: 0;
    height: 18px;
    width: 18px;
    margin: 0;
    cursor: pointer;
}

.custom-checkbox .checkmark {
    position: absolute;
    left: 0;
    top: 0;
    height: 18px;
    width: 18px;
    background-color: #ccc;
    border-radius: 4px;
    transition: background-color 0.2s;
}

.custom-checkbox input:checked + .checkmark {
    background-color: purple;
}

.custom-checkbox .checkmark::after {
    content: "";
    position: absolute;
    display: none;
}

.custom-checkbox input:checked + .checkmark::after {
    display: block;
    left: 6px;
    top: 2px;
    width: 4px;
    height: 8px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}</style>
<body>
<div style="width: 100%; display:flex; gap: 0px;"> 
	<aside class="sidebar">
	 <div class="profile-section" >
	     <i class="fa fa-user"></i>
	     <p>Admin</p>
	     <p>Email@gmail.com</p>
	 </div>
	  <a href="Admin-Dashboard" style="text-decoration: none;" class="sidebar-btn">Dashboard</a>
	  <a href="Add-Games" style="text-decoration: none;"class="sidebar-btn">Add Games</a>
	 <a href="Logout" style="text-decoration: none;" class="sidebar-btn">Logout</a>
	    
	</aside>
<main class="main-content">

    <!-- Main Image Preview -->
    <img id="mainImage" src="#" alt="Main Game Image"
         style="width: 100%; height: auto; display: none; margin-bottom: 1rem;">

    <!-- Game Details Form -->
    <form class="game-form" method="post" action="Add-Games" enctype="multipart/form-data">
        <!-- File Upload -->
        <div class="file-upload-wrapper" style="display: flex; justify-content: center; align-items: center;">
            <label for="gameImages">
                <i class="fas fa-image upload-icon"></i><br><br>
                <span style="color: white;">Select Game Images</span>
            </label>
            <input type="file" id="gameImages" name="gameImages" accept="image/*" multiple required>
        </div>

        <div id="thumbnailContainer" style="display: flex; gap: 10px; margin-top: 1rem;"></div>
		<% String error = (String) request.getAttribute("errorMessage"); %>
		<% if (error != null) { %>
		    <div style="color: red; margin-bottom: 1rem;">
		        <%= error %>
		    </div>
		<% } %>
        <label for="gameName">Game Title</label>
        <input type="text" name="gameName" id="gameName" placeholder="Game Name" required/>

        <label for="description">Game Description</label>
        <textarea name="description" id="description" placeholder="Game Description" required></textarea>

        
            <div>
                <label for="developer">Developer</label>
                <input type="text" name="developer" id="developer" placeholder="Developer Name" required/>
            </div>

            <!-- Platforms -->
			<label>Platforms</label>
			<div class="checkbox-group">
			    <c:forEach var="platform" items="${platforms}">
			        <label class="custom-checkbox">
			            <input type="checkbox" name="platform" value="${platform}">
			            <span class="checkmark"></span>
			            ${platform}
			        </label>
			    </c:forEach>
			</div>
			
			<!-- Genres -->
			<label>Genres</label>
			<div class="checkbox-group">
			    <c:forEach var="genre" items="${genres}">
			        <label class="custom-checkbox">
			            <input type="checkbox" name="genres" value="${genre}">
			            <span class="checkmark"></span>
			            ${genre}
			        </label>
			    </c:forEach>
			</div>
        

        <div class="input-group">
            <div>
                <label for="releaseDate">Release Date</label>
                <input type="date" name="releaseDate" id="releaseDate" required/>
            </div>

            <div>
                <label for="ageRestriction">Age Restrictions</label>
                <select name="ageRestriction" id="ageRestriction" required>
                    <option value="0+">None</option>
                    <option value="13+">13+</option>
                    <option value="18+">18+</option>
                </select>
            </div>
        </div>

        <label for="gameUrl">Game URL</label>
        <input type="url" name="gameUrl" id="gameUrl" placeholder="https://..." />

        <button type="submit">Add Game</button>
    </form>
</main>
</div>

<script>
    const imageInput = document.getElementById('gameImages');
    const thumbnailContainer = document.getElementById('thumbnailContainer');
    const mainImage = document.getElementById('mainImage');

    imageInput.addEventListener('change', function () {
        thumbnailContainer.innerHTML = '';
        const files = Array.from(this.files);

        files.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function (e) {
                const thumb = document.createElement('img');
                thumb.src = e.target.result;
                thumb.style.width = '100px';
                thumb.style.height = '60px';
                thumb.style.cursor = 'pointer';
                thumb.style.borderRadius = '6px';
                thumb.style.objectFit = 'cover';

                thumb.addEventListener('click', function () {
                    mainImage.src = e.target.result;
                    mainImage.style.display = 'block';
                });

                thumbnailContainer.appendChild(thumb);

                if (index === 0) {
                    mainImage.src = e.target.result;
                    mainImage.style.display = 'block';
                }
            };
            reader.readAsDataURL(file);
        });
    });

    // Debug log for public assets path
    console.log("<%= request.getContextPath() %>/assets/usersImages/");
</script>

</body>
</html>

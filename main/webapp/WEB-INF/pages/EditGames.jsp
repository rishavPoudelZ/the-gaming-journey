<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>The Gaming Journey - Edit Game</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AddGame.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    <style>
        /* keep your same checkbox styles */
        .checkbox-group {
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
        }
    </style>
</head>
<body>
<div style="width: 100%; display:flex; gap: 0px;"> 
    <aside class="sidebar">
        <div class="profile-section">
            <i class="fa fa-user"></i>
            <p>Admin</p>
            <p>Email@gmail.com</p>
        </div>
        <a href="Admin-Dashboard" class="sidebar-btn">Dashboard</a>
        <a href="Add-Games" class="sidebar-btn">Add Games</a>
        <a href="Logout" class="sidebar-btn">Logout</a>
    </aside>

    <main class="main-content">
        <form class="game-form" method="post" action="Edit-Game">
            <input type="hidden" name="gameId" value="${game.gameId}" />

            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div style="color: red; margin-bottom: 1rem;">
                    <%= error %>
                </div>
            <% } %>

            <label for="gameName">Game Title</label>
            <input type="text" name="gameName" id="gameName" value="${game.title}" required/>

            <label for="description">Game Description</label>
            <textarea name="description" id="description" required>${game.description}</textarea>

            <label for="developer">Developer</label>
            <input type="text" name="developer" id="developer" value="${game.developer}" required/>

            <!-- Platforms -->
            <label>Platforms</label>
            <div class="checkbox-group">
                <c:forEach var="platform" items="${platforms}">
				    <label class="custom-checkbox">
				        <input type="checkbox" name="platforms" value="${platform}"
				            <c:if test="${fn:contains(selectedPlatforms, platform)}">checked="checked"</c:if> />
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
				        <input type="checkbox" name="genres" value="${genre}"
				            <c:if test="${fn:contains(selectedGenres, genre)}">checked="checked"</c:if> />
				        <span class="checkmark"></span>
				        ${genre}
				    </label>
				</c:forEach>
            </div>

            <div class="input-group">
                <div>
                    <label for="releaseDate">Release Date</label>
                    <input type="date" name="releaseDate" id="releaseDate" value="${game.releaseDate}" required/>
                </div>

                <div>
                    <label for="ageRestriction">Age Restrictions</label>
                    <select name="ageRestriction" id="ageRestriction" required>
                        <option value="0+" <c:if test="${game.ageRestriction eq '0+'}">selected</c:if>>None</option>
                        <option value="13+" <c:if test="${game.ageRestriction eq '13+'}">selected</c:if>>13+</option>
                        <option value="18+" <c:if test="${game.ageRestriction eq '18+'}">selected</c:if>>18+</option>
                    </select>
                </div>
            </div>

            <label for="gameUrl">Game URL</label>
            <input type="url" name="gameUrl" id="gameUrl" value="${game.gameUrl}" />

            <button type="submit">Update Game</button>
        </form>
    </main>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.thegamingjourney.util.CookieUtil" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String loggedInUser = CookieUtil.getCookieValue(request, "tgj_username");
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    </head>
    <body>

        <div class="container">
            <aside class="sidebar">
                <div class="profile-section">
                    <i class="fa fa-user"></i>
                    <p>Admin</p>
                    <p>Email@gmail.com</p>
                </div>
                 <a href="Admin-Dashboard" style="text-decoration: none;" class="sidebar-btn">Dashboard</a>
                 <a href="Add-Games" style="text-decoration: none;"class="sidebar-btn">Add Games</a>
                <a href="Logout" style="text-decoration: none;" class="sidebar-btn">Logout</a>
                
            </aside>

            <main class="main-content">
                <section class="games-section">
                    <a href="Admin-Game-List" style="decoration: none;" >All Games <i class="fa fa-caret-right"></i></a>
                     <div class="game-list" style="margin-top: 10px;">
					    <c:forEach var="game" items="${latestGames}">
					        <div class="game-item">
					            <img src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" alt="${game.title}" alt="${game.title}">
					        </div>
					    </c:forEach>
					</div>
                </section>

                <div class="middle-section" >
                    <section class="reviews-section">
                        <a href="Admin-User-Reviews" style=" margin-left: 5px;">All Reviews <i class="fa fa-caret-right"></i></a>
                        
					    <c:forEach var="review" items="${latestReviews}">
					        <div class="review">
					            
					            <div>
					                <p><strong>${review.username}</strong></p>
					                <p>${review.reviewText}</p>
					            </div>
					        </div>
					    </c:forEach>
						

                    </section>

                    <section class="password-section">
                        <h3>Change Password</h3>
						<c:if test="${not empty error}">
						    <div id="errorMessage" style="color: red;">${error}</div>
						</c:if>
						<c:if test="${not empty success}">
						    <div id="successMessage" style="color: green;">${success}</div>
						</c:if>
						<form action="${pageContext.request.contextPath}/Admin-Dashboard" method="post">
						    <input type="password" placeholder="Current Password" name="CurrentPassword" id="CurrentPassword" required>
						    <input type="password" placeholder="New Password" name="NewPassword" id="NewPassword" required>
						    <input type="password" placeholder="Confirm Password" name="ConfirmPassword" id="ConfirmPassword" required>
						    <button type="submit">Change Password</button>
						</form>
                    </section>
                </div>
            </main>
        </div>
      
		<script>
		    setTimeout(function () {
		        const errorMsg = document.getElementById('errorMessage');
		        const successMsg = document.getElementById('successMessage');
		        if (errorMsg) errorMsg.style.display = 'none';
		        if (successMsg) successMsg.style.display = 'none';
		    }, 2000);
		</script>

    </body>
</html>
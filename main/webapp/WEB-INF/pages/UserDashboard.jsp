<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Dashboard</title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="user.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserDashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    </head>
    <body>
        <jsp:include page="Header.jsp" />

        <main>
            <div class="main-container">
                <div class="left-column">
                    <div class="left-top">
                        <div class="user-info">
                            <img width="150" height="150" src="${pageContext.request.contextPath}/assests/usersImages/${user.profilePictureFileName}" alt="Profile Picture" class="profile-pic" />
                            <div>
                                <p>Username: ${user.username}</p>
                                <p>Email: ${user.email}</p>
                                <p>Member Since: ${user.joinDate}</p>
                            </div>
                        </div>
                    </div>

                    <div class="left-bottom">
                        <p style="cursor: pointer;"><a class="my-favourites" href="<c:url value='/Favourites' />">Favourites <i class="fa fa-caret-right" aria-hidden="true"></i></a></p>

                        <!-- Display Top 3 Favourites -->
                        <div class="game-list">
                            <c:forEach var="game" items="${top3Favourites}">
                                <div class="game-item" onclick="window.location.href='${pageContext.request.contextPath}/Game?id=${game.gameId}'">
                                    <img src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" alt="${game.title}">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="right-column">
                    <div class="right-top">
                        <h3>Change Password</h3>
						<c:if test="${not empty error}">
						    <p style="color: red;">${error}</p>
						</c:if>
						<c:if test="${not empty success}">
						    <p style="color: green;">${success}</p>
						</c:if>
						<form action="${pageContext.request.contextPath}/User-Dashboard" method="post">
						    <input type="password" placeholder="Current Password" name="CurrentPassword" id="CurrentPassword" required>
						    <input type="password" placeholder="New Password" name="NewPassword" id="NewPassword" required>
						    <input type="password" placeholder="Confirm Password" name="ConfirmPassword" id="ConfirmPassword" required>
						    <button type="submit">Change Password</button>
						</form>
                    </div>

                    <div class="right-bottom">
                        <h3> <a class="my-favourites" href="<c:url value='/My-Reviews' />">My reviews <i class="fa fa-caret-right" aria-hidden="true"></i></a></h3>
                        
                        <!-- Display Top 3 Reviews -->
                        <div class="user-reviews">
                            <c:forEach var="review" items="${top3Reviews}">
                                <div class="review-item">
                                    <div class="profile">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                    </div>
                                    <div class="review-content">
                                        <p class="reviewer-name"> <a href="<c:url value='/User-Dashboard' />">${review.username}</a> <span class="review-date">${review.reviewDate}</span> </p>
                                        <p class="review-text">${review.reviewText}</p>
                                        <p class="game-name"><a href="<c:url value='/Game?id=${review.gameId}' />">${review.gameTitle}</a></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="Footer.jsp" />
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <jsp:include page="Header.jsp" />

        <main>
            <div class="main-container">
                <div class="left-column">
                    <div class="left-top">
                        <div class="admin-info">
                            <i class="fa fa-user" aria-hidden="true"></i>
                            <div>
                                <p>Admin</p>
                                <p>exmaple@gmail.com</p>
                            </div>
                        </div>
                        <div class="total-users">
                            Total Users <br>
                            <span class="total-users">100</span>
                        </div>
                    </div>
                    <div class="left-bottom">
                        <p style="cursor: pointer;"><a href>All Games <i
                                    class="fa fa-caret-right"
                                    aria-hidden="true"></i> </a> </p>
                        <div class="game-list">
                            <div class="game-item">
                                <img src="${pageContext.request.contextPath}/assests/discoelysum.jpeg"
                                    alt="Game 1">
                            </div>
                            <div class="game-item">
                                <img src="${pageContext.request.contextPath}/assests/elden ring.png"
                                    alt="Game 2">
                            </div>
                            <div class="game-item">
                                <img src="${pageContext.request.contextPath}/assests/slaythespire.jpeg"
                                    alt="Game 3">
                            </div>
                        </div>
                        <a href="Add-Games" style="text-decoration: none;" class="add-game">
                            <button> Add Game</button>
                        </a>
                    </div>
                </div>
                <div class="right-column">
                    <div class="right-top">
                        <h3>Change Password</h3>
                        <form action="#">
                            <input type="password"
                                placeholder="Current Password"
                                name="CurrentPassword" id="CurrentPassword">
                            <input type="password" placeholder="New Password"
                                name="NewPassword" id="NewPassword">
                            <input type="password"
                                placeholder="Confirm Password"
                                name="ConfirmPassword" id="ConfirmPassword">
                            <button type="submit">Change Password</button>
                        </form>
                    </div>
                    <div class="right-bottom">
                        <h3> <a href="#"><span>User Reviews</span> <i class="fa fa-caret-right"
                                aria-hidden="true"></i> </a></h3>
                        <div class="user-reviews">
                            <div class="review-item">
                                <div class="profile">
                                    <i class="fa fa-user"
                                        aria-hidden="true"></i>
                                </div>
                                <div class="review-content">
                                    <p class="reviewer-name"> <a href="">John Doe</a> <span class="review-date">2023-10-01</span> </p>
                                    <p class="review-text">This game is
                                        amazing! I love the graphics and
                                        gameplay.</p>
                                    <p class="game-name"><a href="">Elden Ring</a></p>
                                </div>
                            </div>
                            <div class="review-item">
                                <div class="profile">
                                    <i class="fa fa-user"
                                        aria-hidden="true"></i>
                                </div>
                                <div class="review-content">
                                    <p class="reviewer-name"> <a href="">John Doe</a> <span class="review-date">2023-10-01</span> </p>
                                    <p class="review-text">This game is
                                        amazing! I love the graphics and
                                        gameplay.</p>
                                    <p class="game-name"><a href="">Elden Ring</a></p>
                                </div>
                            </div>
                            <div class="review-item">
                                <div class="profile">
                                    <i class="fa fa-user"
                                        aria-hidden="true"></i>
                                </div>
                                <div class="review-content">
                                    <p class="reviewer-name"> <a href="">John Doe</a> <span class="review-date">2023-10-01</span> </p>
                                    <p class="review-text">This game is
                                        amazing! I love the graphics and
                                        gameplay.</p>
                                    <p class="game-name"><a href="">Elden Ring</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="Footer.jsp" />
    </body>
</html>
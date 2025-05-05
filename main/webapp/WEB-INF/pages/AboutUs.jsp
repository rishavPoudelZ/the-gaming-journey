<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
    <head>
        <title>The Gaming Journey - About Us</title>
        <link rel="stylesheet" href="../css/styles.css" />
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AboutUs.css">
    </head>
    <body>
        <jsp:include page="Header.jsp" />

        <main>
            <section class="welcome">
                <h2>Welcome to The Gaming Journey</h2>
                <img src="${pageContext.request.contextPath}/assests/Logo.png" alt="ourLogo" width="200px"
                    height="200px">
                <p>
                    Hello Gamers, The Gaming Journey is a website to help find
                    perfect games
                    for you and to communicate with gamers all over the world
                    with similar
                    preferences like yours.
                </p>
            </section>

            <section class="info-section">
                <div class="info-box">
                    <h3>Know Latest Released Games, Top Games of all Time and
                        many more</h3>
                    <p>
                        Easily find details about latest games released, most
                        popular games of all time
                        and easily find games according to your preferences.
                    </p>
                </div>
                <img src="${pageContext.request.contextPath}/assests/newandtop.png" alt="New and Top Games"
                    width="500px" height="200px">
            </section>

            <section class="info-section reverse">
                <img src="${pageContext.request.contextPath}/assests/fav.jpg" alt="Favourite Games">
                <div class="info-box">
                    <h3>Favourite the Games You Love</h3>
                    <p>
                        Easily find the games that you like the most by adding
                        them to your own personal favorites
                    </p>
                </div>
            </section>

            <section class="info-section">
                <div class="info-box">
                    <h3>Voice Your Opinion</h3>
                    <p>
                        Rate the Games according to how much you liked it and
                        share your experiences with others in reviews
                    </p>
                </div>
                <img src="${pageContext.request.contextPath}/assests/rate.jpg" alt="Rating">
            </section>

            <section class="team-section">
                <h3>Meet Our Team</h3>
                <ul>
                    <li>👤 Rishav Poudel<br>Leader of Project | Developer of
                        Header, Footer, Home Page, Admin Dashboard, User
                        Dashboard</li>
                    <li>👤 Rohit Khadka<br>Designer and Developer of Specific
                        Game Page, Admin Reviews Supervise Page, User Reviews
                        Backtracking Page</li>
                    <li>👤 Aakriti Karki<br>Designer and Developer of Login
                        Page, Register Page, Games Genres Seperation Page</li>
                    <li>👤 Krijal Koju<br>Designer and Developer of Games List
                        Page, User Favorites Page</li>
                    <li>👤 Sujal Maharjan<br>Designer of Home, Login, Register,
                        User Dashboard, Admin Dashboard, About Us Pages,
                        Developer of About Us Page, Add Game Page</li>
                </ul>
            </section>
        </main>

        <jsp:include page="Footer.jsp" />
    </body>
</html>
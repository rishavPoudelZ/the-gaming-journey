<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HomePage.css">
    </head>
    <body>
    <jsp:include page="Header.jsp" />
        <main>
            <div class="hero">
                <img class="hero-image" src="${pageContext.request.contextPath}/assests/elden ring.png"
                    alt="Hero Image">
            </div>
            <div class="hero-arrows">
                <i class="fa fa-caret-left" aria-hidden="true"></i>
                <i class="fa fa-caret-right" aria-hidden="true"></i>
            </div>
        </main>

        <section style="padding: 30px;">
            <div class="games-container">
                <div class="games-row">
                    <h2>New Releases <i class="fa fa-caret-right"
                            aria-hidden="true"></i></h2>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/2k25.jpeg" loading="lazy"
                            alt="2k25">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/fronttiers.jpeg" loading="lazy"
                            alt="2">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/splitfiction.png" loading="lazy"
                            alt="3">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/avowed.jpeg" loading="lazy"
                            alt="4">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/monsterhunnter.jpeg" loading="lazy"
                            alt="5">
                    </div>
                </div>
                <div class="games-row">
                    <h2>Top Games <i class="fa fa-caret-right"
                            aria-hidden="true"></i></h2>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/balduresgate.jpeg" loading="lazy"
                            alt="2k25">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/elden ring.png" loading="lazy"
                            alt="2">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/discoelysum.jpeg" loading="lazy"
                            alt="3">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/slaythespire.jpeg" loading="lazy"
                            alt="4">
                    </div>
                    <div class="game-card">
                        <img src="${pageContext.request.contextPath}/assests/monsterhunnter.jpeg" loading="lazy"
                            alt="5">
                    </div>
                </div>

            </div>
        </section>
	
        <jsp:include page="Footer.jsp" />
    </body>
</html>
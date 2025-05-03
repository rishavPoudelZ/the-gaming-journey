<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Favorite List</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" tags="text/css" href="../Css/FavorateP.css">
        <link rel="Image" href="../picture/p.jpg">
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserFavouriteList.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
    </head>
    <body>
        <jsp:include page="Header.jsp" />
        
        <div class="favorite-list-container">
            <h2 class="favorite-list-title">My Favorite List</h2>
            <div class="table-container">
                <div class="favorite-list-table">
                    <div class="table-header">
                        <div class="number-header">#</div>
                        <div class="image-header">Image</div>
                        <div class="title-header">Game Title</div>
                        <div class="rating-header">Rating</div>
                        <div class="tags-header">tags</div>
                        <div class="actions-header">Actions</div>
                    </div>
                    <div class="table-body">
                        <div class="table-row">
                            <div class="cell-number">1</div>
                            <div class="cell-image"><img src="../picture/P1.jpg"
                                    alt="Assassin's Creed Shadows"></div>
                            <div class="cell-title">Assassin's Creed
                                Shadows<br><sub>Ubisoft Quebec Mar 20,
                                    2025</sub></div>
                            <div class="cell-rating">★★★★☆</div>
                            <div class="cell-tags">Action-adventure,
                                Role-playing, Stealth</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">2</div>
                            <div class="cell-image"><img src="../picture/P2.jpg"
                                    alt="Atomfall"></div>
                            <div class="cell-title">Atomfall<br><sub>Rebellion
                                    Mar 27, 2025</sub></div>
                            <div class="cell-rating">★★★☆☆</div>
                            <div class="cell-tags">Action</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">3</div>
                            <div class="cell-image"><img src="../picture/p3.jpg"
                                    alt="Split Fiction"></div>
                            <div class="cell-title">Split
                                Fiction<br><sub>Hazelight Studios Mar 6,
                                    2025</sub></div>
                            <div class="cell-rating">★★★☆☆</div>
                            <div class="cell-tags">Action-adventure</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">4</div>
                            <div class="cell-image"><img src="../picture/p4.jpg"
                                    alt="Hogwarts Legacy"></div>
                            <div class="cell-title">Hogwarts
                                Legacy<br><sub>Avalanche Feb 10,
                                    2023</sub></div>
                            <div class="cell-rating">★★★★☆</div>
                            <div class="cell-tags">Open-world,
                                Action-adventure</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">5</div>
                            <div class="cell-image"><img src="../picture/p5.jpg"
                                    alt="Red Dead Redemption 2"></div>
                            <div class="cell-title">Red Dead Redemption
                                2<br><sub>Rockstar Studios Oct 26,
                                    2018</sub></div>
                            <div class="cell-rating">★★★★★</div>
                            <div class="cell-tags">Open-world, Action
                                Role-playing</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">6</div>
                            <div class="cell-image"><img src="../picture/p6.jpg"
                                    alt="Super Mario World"></div>
                            <div class="cell-title">Super Mario
                                World<br><sub>Rebellion Nov 21, 1990</sub></div>
                            <div class="cell-rating">★★★★★</div>
                            <div class="cell-tags">2D Side-scrolling
                                Platformer</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">7</div>
                            <div class="cell-image"><img src="../picture/p7.jpg"
                                    alt="Genshin Impact"></div>
                            <div class="cell-title">Genshin
                                Impact<br><sub>HoYoverse Sep 27,
                                    2020</sub></div>
                            <div class="cell-rating">★★★★★</div>
                            <div class="cell-tags">Free-to-play, Open-world
                                Action Role-playing</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">8</div>
                            <div class="cell-image"><img src="../picture/p8.jpg"
                                    alt="The Last of Us"></div>
                            <div class="cell-title">The Last of
                                Us<br><sub>Naughty Dog Jun 14, 2013</sub></div>
                            <div class="cell-rating">★★★★☆</div>
                            <div class="cell-tags">Third-person
                                Action-adventure</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">9</div>
                            <div class="cell-image"><img src="../picture/p9.jpg"
                                    alt="The Elder Scrolls V: Skyrim"></div>
                            <div class="cell-title">The Elder Scrolls V:
                                Skyrim<br><sub>Bethesda Game Studios Nov 10,
                                    2011</sub></div>
                            <div class="cell-rating">★★★★☆</div>
                            <div class="cell-tags">Single-player action
                                role-playing game (ARPG)</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">10</div>
                            <div class="cell-image"><img
                                    src="../picture/p10.jpg"
                                    alt="Ghost of Tsushima"></div>
                            <div class="cell-title">Ghost of
                                Tsushima<br><sub>Sucker Punch Jul 16,
                                    2020</sub></div>
                            <div class="cell-rating">★★★★☆</div>
                            <div class="cell-tags">Action-adventure</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">11</div>
                            <div class="cell-image"><img
                                    src="../picture/p11.jpg"
                                    alt="Journey"></div>
                            <div class="cell-title">Journey<br><sub>That game
                                    company (TGC) Mar 13, 2012</sub></div>
                            <div class="cell-rating">★★★★★</div>
                            <div class="cell-tags">Indie adventure</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>
                        <div class="table-row">
                            <div class="cell-number">12</div>
                            <div class="cell-image"><img
                                    src="../picture/p12.jpg"
                                    alt="God of War: Ragnarok"></div>
                            <div class="cell-title">God of War:
                                Ragnarok<br><sub>Santa Monica STudio Nov 9,
                                    2022</sub></div>
                            <div class="cell-rating">★★★★★</div>
                            <div class="cell-tags">Third-person action-adventure
                                gam</div>
                            <div class="cell-actions">
                                <button class="delete-button">Remove</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp" />
    </body>
</html>

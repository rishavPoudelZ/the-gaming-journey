<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
            	<c:set var="counter" value="0" />
				<c:forEach var="game" items="${gamesList}" varStatus="status">
				    <c:if test="${status.index % 5 == 0}">
				        <c:if test="${status.index != 0}">
				            </div> <!-- close previous games-row -->
				        </c:if>
				        <div class="games-row">
				            <h2>Top Games <i class="fa fa-caret-right" aria-hidden="true"></i></h2>
				    </c:if>
				
				    <div class="game-card">
				        <img 
				            src="${pageContext.request.contextPath}/assets/gamesImages/${fn:replace(game.title, ' ', '_')}/${fn:replace(game.title, ' ', '_')}_image1.jpg" 
				            alt="${game.title}" 
				            loading="lazy"
				        />
				    </div>
				
				    <c:if test="${status.last}">
				        </div> <!-- close last games-row -->
				    </c:if>
				</c:forEach>
            
            </div>
        </section>
	
        <jsp:include page="Footer.jsp" />
    </body>
</html>
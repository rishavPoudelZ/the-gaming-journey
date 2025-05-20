<%@ page import="com.thegamingjourney.util.CookieUtil" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String loggedInUser = CookieUtil.getCookieValue(request, "tgj_username");
%>

<style>
    .user-actions {
        position: relative;
        display: flex;
        align-items: center;
    }

    .user-info-header {
        display: flex;
        align-items: center;
        gap: 10px;
        cursor: default;
        position: relative;
    }

    .user-icon {
        font-size: 20px;
    }

    .dots {
        font-weight: bold;
        cursor: pointer;
        padding: 0 5px;
    }

    .dropdown {
        position: absolute;
        top: 100%;
        right: 0;
        background-color: white;
        border: 1px solid #ccc;
        padding: 8px 0;
        display: none;
        flex-direction: column;
        min-width: 150px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        z-index: 100;
    }

    .dropdown a {
        padding: 8px 16px;
        text-decoration: none;
        color: black;
        display: block;
    }

    .dropdown a:hover {
        background-color: #f0f0f0;
    }

    .dropdown.show {
        display: flex;
    }
</style>

<header>
    <div class="nav-bar">
        <div class="left-nav">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/assests/Logo.png" alt="logo">
            </div>
            <nav class="nav-buttons">
                <a href="<c:url value='/Home' />">Home</a>
			    <a href="<c:url value='/Games' />">Games</a>
			    <a href="<c:url value='/Favourites' />">Favourites</a>
			    <a href="<c:url value='/About-Us' />">About us</a>
            </nav>
        </div>
        <div class="user-actions">
            <% if (loggedInUser != null) { %>
                <div class="user-info-header">
                    <i class="fa fa-user-circle" aria-hidden="true"></i>
                    <span><%= loggedInUser %></span>
                    <span class="dots" onclick="toggleDropdown()">&#8942;</span>
                    <div class="dropdown" id="userDropdown">
                        <a href="User-Dashboard">Profile</a>
                        <a href="Logout">Logout</a>
                    </div>
                </div>
            <% } else { %>
                <a href="Login">Login</a>
            <% } %>
        </div>
    </div>
</header>

<script>
    function toggleDropdown() {
        const dropdown = document.getElementById("userDropdown");
        dropdown.classList.toggle("show");
    }

    // Optional: close dropdown when clicking outside
    document.addEventListener("click", function (event) {
        const dropdown = document.getElementById("userDropdown");
        const dots = document.querySelector(".dots");

        if (!dropdown.contains(event.target) && !dots.contains(event.target)) {
            dropdown.classList.remove("show");
        }
    });
</script>

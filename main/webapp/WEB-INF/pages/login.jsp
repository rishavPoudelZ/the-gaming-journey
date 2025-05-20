<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Login.css">
    <script>
        // Auto-hide the error message after 5 seconds
        window.onload = function () {
            const errorBox = document.getElementById("errorMessage");
            if (errorBox) {
                setTimeout(() => {
                    errorBox.style.display = "none";
                }, 5000);
            }
        };
    </script>
</head>
<body>
    <div class="container">
        <h1 class="brand">The Gaming Journey</h1>
        <div class="login-box">
            <h2><center>Welcome To<br>The Gaming Journey</center></h2>
            
            <!-- ✅ Display error message if exists -->
            <% String error = (String) request.getAttribute("error");
            if (error != null) { %>
            <div id="errorMessage"
                style="color: red; text-align: center; margin-bottom: 10px;">
                <%= error %>
            </div>
            <% } %>
            
            <form action="Login" method="post">
            
                <label for="username">User Name</label>
                <input type="text" id="username" name="username" placeholder="User Name" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Password" required>

                <button type="submit" class="login-button">Log In</button>
            </form>

            <p class="signup">
                Not on The Gaming Journey yet? <a href="Register">Sign up</a>
            </p>
        </div>
    </div>
</body>
</html>
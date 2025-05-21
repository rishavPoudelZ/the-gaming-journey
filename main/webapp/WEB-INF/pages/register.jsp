<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="css/Register.css">

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
        <div class="register-box">
            <h2><center>Welcome to <br>The Gaming Journey</center></h2>

            <!-- ✅ Display error message if exists -->
            <% String error = (String) request.getAttribute("error");
            if (error != null) { %>
            <div id="errorMessage"
                style="color: red; text-align: center; margin-bottom: 10px;">
                <%= error %>
            </div>
            <% } %>

            <form action="Register" method="post" enctype="multipart/form-data">
            	<label for="profilePic">Profile Picture</label>
    			<input type="file" id="profilePic" name="profilePic" accept="image/*" required>

    			
                <label for="username">User Name</label>
                <input type="text" id="username" name="username" placeholder="User Name" required>

                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Email" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Password" required>

                <label for="retypePassword">Confirm Password</label>
                <input type="password" id="retypePassword" name="retypePassword" placeholder="Confirm Password" required>

                <!-- ✅ Checkbox inside the form with proper label -->
                <div style="margin: 10px 0;">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">
                        By signing up you agree to The Gaming Journey’s<br>
                        <b>Terms and Services</b> and acknowledge you've read our<br>
                        <b>Privacy Policy Notice</b>
                    </label>
                </div>

                <button type="submit" class="register-button">Register</button>
            </form>

            <hr>

            <p class="Login">
                Already have an account? <a href="Login">Log in</a>
            </p>
        </div>
    </div>
</body>
<script>
	document.querySelector("form").addEventListener("submit", () => {
  	console.log("Form submitted with profile pic: ", document.getElementById("profilePic").files[0]);
	});
</script>
</html>

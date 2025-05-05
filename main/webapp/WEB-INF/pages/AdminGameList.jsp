<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Games List</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../Css/AdminP.css">
        <link rel="Image" href="../picture/p.jpg">
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminGamelist.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/HeaderFooter.css">
        
    </head>
    <body>
        <jsp:include page="Header.jsp" />
        
        <div class="favorite-list-container">
            <h2 class="favorite-list-title">All Games List</h2>
            <div class="table-container">
                <div class="favorite-list-table">
                    <div class="table-header">
                        <div class="number-header">#</div>
                        <div class="image-header">Image</div>
                        <div class="title-header">Game Name</div>
                        <div class="rating-header">Rating</div>
                        <div class="tags-header">Genre</div>
                        <div class="actions-header">Actions</div>
                    </div>
                    <div class="table-body">
                        <%
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            
                            try {
                                // Database connection parameters
                                String dbURL = "jdbc:mysql://localhost:3306/tgj";
                                String dbUser = "root";
                                String dbPass = ""; // Your XAMPP MySQL password
                                
                                // Load MySQL JDBC driver
                                Class.forName("com.mysql.jdbc.Driver");
                                
                                // Establish connection
                                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                                
                                // SQL query to retrieve all games
                                String sql = "SELECT * FROM favourate";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                
                                int count = 1;
                                while (rs.next()) {
                                    String gameId = rs.getString("game_id");
                                    String imagePath = rs.getString("image_path");
                                    String title = rs.getString("title");
                                    String developer = rs.getString("developer");
                                    String releaseDate = rs.getString("release_date");
                                    String rating = rs.getString("rating");
                                    String tags = rs.getString("tags");
                        %>
                        <div class="table-row">
                            <div class="cell-number"><%= count %></div>
                            <div class="cell-image">
                                <img src="${pageContext.request.contextPath}<%= imagePath %>" alt="<%= title %>">
                            </div>
                            <div class="cell-title">
                                <%= title %><br>
                                <sub><%= developer %> <%= releaseDate %></sub>
                            </div>
                            <div class="cell-rating"><%= rating %></div>
                            <div class="cell-tags"><%= tags %></div>
                            <div class="cell-actions">
                                <button class="edit-button" onclick="editGame('<%= gameId %>')">Edit</button>
                                <button class="delete-button" onclick="deleteGame('<%= gameId %>')">Delete</button>
                            </div>
                        </div>
                        <%
                                    count++;
                                }
                            } catch (ClassNotFoundException e) {
                                out.println("Error: MySQL JDBC driver not found");
                                e.printStackTrace();
                            } catch (SQLException e) {
                                out.println("Error connecting to database: " + e.getMessage());
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                                if (conn != null) try { conn.close(); } catch (SQLException e) {}
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="Footer.jsp" />
        
        <script>
            // Function to handle game editing
            function editGame(gameId) {
                // Redirect to edit page with gameId
                window.location.href = 'EditGame.jsp?gameId=' + gameId;
            }
            
            // Function to handle game deletion
            function deleteGame(gameId) {
                if (confirm('Are you sure you want to delete this game?')) {
                    // Send AJAX request to delete the game
                    const xhr = new XMLHttpRequest();
                    xhr.open('POST', 'DeleteGameServlet', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onload = function() {
                        if (xhr.status === 200) {
                            // Reload the page to reflect changes
                            window.location.reload();
                        } else {
                            alert('Error deleting game: ' + xhr.responseText);
                        }
                    };
                    xhr.send('gameId=' + encodeURIComponent(gameId));
                }
            }
        </script>
    </body>
</html>
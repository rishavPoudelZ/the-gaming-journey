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
        <title>My Favorite List</title> 
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link rel="stylesheet" tags="text/css" href="../Css/FavorateP.css">
        <link rel="icon" href="../picture/p.jpg">
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
            
            <table class="favorite-list-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Game Title</th>
                        <th>Rating</th>
                        <th>Tags</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
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
                            
                            // SQL query to retrieve favorite games
                            String sql = "SELECT * FROM favourites";
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
                    <tr>
                        <td><%= count %></td>
                        <td><img src="<%= imagePath %>" alt="<%= title %>"></td>
                        <td>
                            <div class="game-title"><%= title %></div>
                            <div class="game-developer"><%= developer %> <%= releaseDate %></div>
                        </td>
                        <td class="rating-stars"><%= rating %></td>
                        <td class="game-tags"><%= tags %></td>
                        <td>
                            <button class="remove-btn" onclick="removeFavorite('<%= gameId %>', this)">Remove</button>
                        </td>
                    </tr>
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
                </tbody>
            </table>
        </div>
        
        <jsp:include page="Footer.jsp" />
        
        <script>
            // Remove favorite game
            function removeFavorite(gameId, button) {
                if (confirm('Are you sure you want to remove this game from your favorites?')) {
                    // Send AJAX request to server to remove the favorite
                    const xhr = new XMLHttpRequest();
                    xhr.open('POST', 'RemoveFavoriteServlet', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onload = function() {
                        if (xhr.status === 200) {
                            // Remove the row from the UI
                            const row = button.closest('tr');
                            row.style.display = 'none';
                        } else {
                            alert('Error removing favorite: ' + xhr.responseText);
                        }
                    };
                    xhr.send('gameId=' + encodeURIComponent(gameId));
                }
            }
        </script>
    </body>
</html>
package com.thegamingjourney.dao;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.User;
import com.thegamingjourney.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<Game> getTop3FavouritesByUsername(String username) throws ClassNotFoundException {
        List<Game> favourites = new ArrayList<>();

        String sql = """
            SELECT g.gameId, g.title, g.imagesUrl
            FROM favourites f
            JOIN games g ON f.gameId = g.gameId
            JOIN users u ON f.userId = u.userId
            WHERE u.userName = ?
            ORDER BY f.favouriteId DESC
            LIMIT 3
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Game game = new Game();
                    game.setGameId(rs.getInt("gameId"));
                    game.setTitle(rs.getString("title"));
                    game.setImagesUrl(rs.getString("imagesUrl"));
                    favourites.add(game);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return favourites;
    }
    
    public void updatePassword(String username, String encryptedPassword) throws ClassNotFoundException {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, encryptedPassword);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("userId"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getDate("joindate").toLocalDate(),
                    rs.getString("profile_picture_filename")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

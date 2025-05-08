package com.thegamingjourney.service;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserFavouriteListService {

    public List<Game> getFavouriteGamesByUserId(int userId) throws ClassNotFoundException {
        List<Game> favouriteGames = new ArrayList<>();

        String sql = """
            SELECT g.*
            FROM favourites f
            JOIN games g ON f.gameId = g.gameId
            WHERE f.userId = ?
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Game game = new Game();
                game.setGameId(rs.getInt("gameId"));
                game.setTitle(rs.getString("title"));
                game.setDescription(rs.getString("description"));
                game.setDeveloper(rs.getString("developer"));
                game.setReleaseDate(rs.getDate("releaseDate"));
                game.setAvgRating(rs.getInt("avgRating"));
                game.setImagesUrl(rs.getString("imagesUrl"));
                favouriteGames.add(game);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return favouriteGames;
    }

    public boolean removeFavouriteGame(int userId, int gameId) throws ClassNotFoundException {
        String sql = "DELETE FROM favourites WHERE userId = ? AND gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

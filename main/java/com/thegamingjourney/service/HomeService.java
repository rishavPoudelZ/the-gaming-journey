package com.thegamingjourney.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.config.DbConfig;

public class HomeService {

    public List<Game> getTopGames() throws ClassNotFoundException {
        List<Game> games = new ArrayList<>();

        // Modify the query to sort by average rating and limit to the top 10 games
        String query = "SELECT * FROM games ORDER BY avgRating DESC LIMIT 10";  // Sorting by highest rating and limiting to 10 rows

        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Game game = new Game();
                game.setGameId(rs.getInt("gameId"));
                game.setTitle(rs.getString("title"));
                game.setDescription(rs.getString("description"));
                game.setDeveloper(rs.getString("developer"));
                game.setReleaseDate(rs.getDate("releaseDate"));
                game.setDateUploaded(rs.getDate("dateUploaded"));
                game.setImagesUrl(rs.getString("imagesUrl"));
                game.setAvgRating(rs.getInt("avgRating"));
                game.setGameUrl(rs.getString("GameUrl"));
                game.setAgeRestriction(rs.getString("age_restriction"));

                games.add(game);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return games;
    }
}

package com.thegamingjourney.service;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Review;

import com.thegamingjourney.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GamePageService {

    public Game getGameById(int gameId) throws ClassNotFoundException {
        Game game = null;
        String gameQuery = "SELECT * FROM games WHERE gameId = ?";
        String genreQuery = "SELECT g.name FROM genres g JOIN genres_games gg ON g.genreId = gg.genreId WHERE gg.gameId = ?";
        String platformQuery = "SELECT p.name FROM platforms p JOIN platforms_games pg ON p.platformId = pg.platformId WHERE pg.gameId = ?";

        try (Connection conn = DbConfig.getDbConnection()) {
            // Fetch base game details
            try (PreparedStatement stmt = conn.prepareStatement(gameQuery)) {
                stmt.setInt(1, gameId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    game = new Game();
                    game.setGameId(rs.getInt("gameId"));
                    game.setTitle(rs.getString("title"));
                    game.setDescription(rs.getString("description"));
                    game.setDeveloper(rs.getString("developer"));
                    game.setReleaseDate(rs.getDate("releaseDate"));
                    game.setDateUploaded(rs.getDate("dateUploaded"));
                    game.setImagesUrl(rs.getString("imagesUrl"));
                    game.setAvgRating(rs.getInt("avgRating"));
                    game.setGameUrl(rs.getString("gameUrl"));
                    game.setAgeRestriction(rs.getString("age_restriction"));
                }
            }

            // Fetch and concatenate genres
            if (game != null) {
                List<String> genres = new ArrayList<>();
                try (PreparedStatement stmt = conn.prepareStatement(genreQuery)) {
                    stmt.setInt(1, gameId);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        genres.add(rs.getString("name"));
                    }
                }
                game.setGenres(genres);

                // Fetch and append platforms to gameUrl temporarily or store if you want in a new field
                List<String> platforms = new ArrayList<>();
                try (PreparedStatement stmt = conn.prepareStatement(platformQuery)) {
                    stmt.setInt(1, gameId);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        platforms.add(rs.getString("name"));
                    }
                }
                game.setPlatforms(platforms);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return game;
    }

    public List<Review> getReviewsForGame(int gameId) throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        String sql = """
                SELECT r.*, u.username
                FROM reviews r
                JOIN users u ON r.userId = u.userId
                WHERE r.gameId = ?
                ORDER BY r.reviewDate DESC
                """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, gameId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("reviewId"));
                review.setUserId(rs.getInt("userId"));
                review.setGameId(rs.getInt("gameId"));
                review.setReviewText(rs.getString("reviewText"));
                review.setReviewDate(rs.getDate("reviewDate"));
                review.setLikes(rs.getInt("likes"));
                review.setDislikes(rs.getInt("dislikes"));
                review.setUsername(rs.getString("username"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}

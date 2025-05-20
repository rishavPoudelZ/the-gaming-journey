package com.thegamingjourney.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Review;
import com.thegamingjourney.config.DbConfig;

public class AdminDashboardService {

    public List<Game> getLatestGames() throws ClassNotFoundException {
        List<Game> games = new ArrayList<>();
        String sql = "SELECT * FROM games ORDER BY dateUploaded DESC LIMIT 6";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Game game = new Game();
                game.setGameId(rs.getInt("gameId"));
                game.setTitle(rs.getString("title"));
                game.setImagesUrl(rs.getString("imagesUrl"));
                games.add(game);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return games;
    }

    public List<Review> getLatestReviews() throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        String sql = """
            SELECT r.reviewText, r.reviewDate, u.username 
            FROM reviews r 
            JOIN users u ON r.userId = u.userId 
            ORDER BY r.reviewDate DESC 
            LIMIT 2
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Review review = new Review();
                review.setReviewText(rs.getString("reviewText"));
                review.setReviewDate(rs.getDate("reviewDate"));
                review.setUsername(rs.getString("username"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}

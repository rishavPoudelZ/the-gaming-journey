package com.thegamingjourney.dao;

import com.thegamingjourney.model.Review;
import com.thegamingjourney.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public List<Review> getTop3ReviewsByUsername(String username) throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();

        String sql = """
            SELECT r.reviewId, r.reviewText, r.reviewDate, g.gameId, g.title AS gameTitle
            FROM reviews r
            JOIN users u ON r.userId = u.userId
            JOIN games g ON r.gameId = g.gameId
            WHERE u.userName = ?
            ORDER BY r.reviewDate DESC
            LIMIT 3
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("reviewId"));
                    review.setReviewText(rs.getString("reviewText"));
                    review.setReviewDate(rs.getDate("reviewDate"));
                    review.setGameId(rs.getInt("gameId"));
                    review.setGameTitle(rs.getString("gameTitle"));
                    review.setUsername(username);
                    reviews.add(review);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}

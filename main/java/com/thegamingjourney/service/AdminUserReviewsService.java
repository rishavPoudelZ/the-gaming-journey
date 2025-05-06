package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminUserReviewsService {
    private static final int PAGE_SIZE = 10;

    public List<Review> getReviews(int page) throws SQLException, ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.reviewId, r.userId, r.gameId, r.reviewText, " +
                     "r.reviewDate, r.likes, r.dislikes " +
                     "FROM reviews r " +
                     "JOIN users u ON r.userId = u.userId " +
                     "JOIN games g ON r.gameId = g.gameId " +
                     "ORDER BY r.reviewDate DESC LIMIT ? OFFSET ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, PAGE_SIZE);
            stmt.setInt(2, (page - 1) * PAGE_SIZE);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("reviewId"));
                    review.setUserId(rs.getInt("userId"));
                    review.setGameId(rs.getInt("gameId"));
                    review.setReviewText(rs.getString("reviewText"));
                    review.setReviewDate(rs.getDate("reviewDate").toLocalDate());
                    review.setLikes(rs.getInt("likes"));
                    review.setDislikes(rs.getInt("dislikes"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public int getTotalPages() throws SQLException {
        String sql = "SELECT COUNT(*) FROM reviews";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int total = rs.getInt(1);
                return (int) Math.ceil((double) total / PAGE_SIZE);
            }
        }
        return 0;
    }

    public boolean deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE reviewId = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            return stmt.executeUpdate() > 0;
        }
    }
}
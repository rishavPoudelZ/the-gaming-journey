package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserReviewService {

	public List<Review> getReviewsByUserId(int userId) throws ClassNotFoundException {
	    List<Review> reviews = new ArrayList<>();

	    String sql = """
	        SELECT r.*, u.username, g.title AS gameTitle
	        FROM reviews r
	        JOIN users u ON r.userId = u.userId
	        JOIN games g ON r.gameId = g.gameId
	        WHERE r.userId = ?
	        ORDER BY r.reviewDate DESC
	    """;

	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setInt(1, userId);
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
	            review.setGameTitle(rs.getString("gameTitle"));
	            reviews.add(review);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return reviews;
	}
	
	public boolean deleteReviewById(int userId, int reviewId) throws ClassNotFoundException {
	    String sql = "DELETE FROM reviews WHERE reviewId = ? AND userId = ?";

	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, reviewId);
	        stmt.setInt(2, userId);
	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
}

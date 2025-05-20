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
        String sql = "SELECT r.reviewId, r.userId, u.username, r.gameId, g.title AS gameTitle,\r\n"
        		+ "       r.reviewText, r.reviewDate, r.likes, r.dislikes\r\n"
        		+ "FROM reviews r\r\n"
        		+ "JOIN users u ON r.userId = u.userId\r\n"
        		+ "JOIN games g ON r.gameId = g.gameId\r\n"
        		+ "ORDER BY r.reviewDate DESC\r\n"
        		+ "LIMIT ? OFFSET ?\r\n";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DbConfig.getDbConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, PAGE_SIZE);
            stmt.setInt(2, (page - 1) * PAGE_SIZE);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setUsername(rs.getString("username"));
                review.setGameTitle(rs.getString("gameTitle"));
                review.setReviewId(rs.getInt("reviewId"));
                review.setUserId(rs.getInt("userId"));
                review.setGameId(rs.getInt("gameId"));
                review.setReviewText(rs.getString("reviewText"));
                review.setReviewDate(rs.getDate("reviewDate"));

                review.setLikes(rs.getInt("likes"));
                review.setDislikes(rs.getInt("dislikes"));
                reviews.add(review);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error during database connection or query execution: " + e.getMessage());
            e.printStackTrace();  // Prints the stack trace for debugging
            throw e;  // Re-throw the exception after logging
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error during resource cleanup: " + e.getMessage());
                e.printStackTrace();  // Prints the stack trace for debugging
            }
        }
        return reviews;
    }

    public int getTotalPages() throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM reviews";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DbConfig.getDbConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            if (rs.next()) {
                int total = rs.getInt(1);
                return (int) Math.ceil((double) total / PAGE_SIZE);
            }
            return 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error during database connection or query execution: " + e.getMessage());
            e.printStackTrace();  // Prints the stack trace for debugging
            throw e;  // Re-throw the exception after logging
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error during resource cleanup: " + e.getMessage());
                e.printStackTrace();  // Prints the stack trace for debugging
            }
        }
    }

    public boolean deleteReview(int reviewId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM reviews WHERE reviewId = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DbConfig.getDbConnection();
            conn.setAutoCommit(false);
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, reviewId);

            int affectedRows = stmt.executeUpdate();
            conn.commit();

            return affectedRows > 0;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    System.err.println("Error during rollback: " + rollbackEx.getMessage());
                    rollbackEx.printStackTrace();  // Prints the stack trace for debugging
                }
            }
            System.err.println("Error during database operation: " + e.getMessage());
            e.printStackTrace();  // Prints the stack trace for debugging
            throw e;  // Re-throw the exception after logging
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error during resource cleanup: " + e.getMessage());
                e.printStackTrace();  // Prints the stack trace for debugging
            }
        }
    }
}
package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for retrieving user reviews from the database.
 * 
 * This class connects to the database, fetches review records, and returns 
 * them as a list of Review model objects. It handles database access logic 
 * and error handling internally.
 */
public class AdminUserReviewsService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection.
     * Sets a flag if a connection error occurs.
     */
    public AdminUserReviewsService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();  // Ideally use a logger
            isConnectionError = true;
        }
    }

    /**
     * Retrieves all user reviews from the database.
     * 
     * @return A list of Review objects, or an empty list if none found or an error occurs.
     */
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();

        if (isConnectionError) {
            return reviews;  // Return empty list if DB connection failed
        }

        String sql = "SELECT review_id, game_title, username, rating, review_text FROM reviews";

        try (PreparedStatement statement = dbConn.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Review review = new Review();
                review.setId(resultSet.getInt("review_id"));
                review.setGameTitle(resultSet.getString("game_title"));
                review.setUsername(resultSet.getString("username"));
                review.setRating(resultSet.getInt("rating"));
                review.setText(resultSet.getString("review_text"));
                reviews.add(review);
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Ideally use a logger
        }

        return reviews;
    }
}

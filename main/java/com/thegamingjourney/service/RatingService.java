package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;

import java.sql.*;

public class RatingService {

    public int getUserRating(int userId, int gameId) throws ClassNotFoundException {
        int rating = 0;
        String sql = "SELECT ratingValue FROM ratings WHERE userId = ? AND gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                rating = rs.getInt("ratingValue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rating;
    }

    public void deleteRating(int userId, int gameId) throws ClassNotFoundException {
        String sql = "DELETE FROM ratings WHERE userId = ? AND gameId = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addRating(int userId, int gameId, int ratingValue) throws ClassNotFoundException {
        String sql = "INSERT INTO ratings (userId, gameId, ratingValue, ratingDate) VALUES (?, ?, ?, CURDATE())";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, gameId);
            stmt.setInt(3, ratingValue);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int recalculateAndUpdateAvgRating(int gameId) throws ClassNotFoundException {
        int avgRating = 0;
        String selectSql = "SELECT AVG(ratingValue) AS avgRating FROM ratings WHERE gameId = ?";
        String updateSql = "UPDATE games SET avgRating = ? WHERE gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();) {
            try (PreparedStatement stmt = conn.prepareStatement(selectSql)) {
                stmt.setInt(1, gameId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    avgRating = (int) Math.round(rs.getDouble("avgRating"));
                }
            }

            try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                stmt.setInt(1, avgRating);
                stmt.setInt(2, gameId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return avgRating;
    }
}

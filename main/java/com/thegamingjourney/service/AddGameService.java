package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddGameService {

    public void saveGameWithImages(HttpServletRequest request, String gameTitle, List<Part> imageParts, String uploadPath, String[] selectedGenres, String[] selectedPlatforms)
            throws IOException, ClassNotFoundException {

        File gameDir = new File(uploadPath);
        if (!gameDir.exists()) gameDir.mkdirs();

        List<String> imageFileNames = new ArrayList<>();
        int count = 1;
        for (Part part : imageParts) {
            String extension = getFileExtension(part);
            String sanitizedTitle = gameTitle.replaceAll("\\s+", "_");
            String fileName = sanitizedTitle + "_image" + count + extension;
            String fullPath = uploadPath + File.separator + fileName;

            part.write(fullPath);
            imageFileNames.add("assets/gamesImages/" + sanitizedTitle + "/" + fileName);
            count++;
        }

        String imagePathsString = String.join(",", imageFileNames);

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false); // Begin transaction

            String sql = "INSERT INTO games (title, description, developer, releaseDate, DateUploaded, imagesUrl, age_restriction, GameUrl) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            int gameId;

            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, request.getParameter("gameName"));
                stmt.setString(2, request.getParameter("description"));
                stmt.setString(3, request.getParameter("developer"));
                stmt.setDate(4, Date.valueOf(request.getParameter("releaseDate")));
                stmt.setDate(5, new java.sql.Date(System.currentTimeMillis()));
                stmt.setString(6, uploadPath);
                stmt.setString(7, request.getParameter("ageRestriction"));
                stmt.setString(8, request.getParameter("gameUrl"));

                int affectedRows = stmt.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback();
                    throw new SQLException("Inserting game failed, no rows affected.");
                }

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        gameId = rs.getInt(1);
                    } else {
                        conn.rollback();
                        throw new SQLException("Game ID not generated.");
                    }
                }
            }

            // Link to genres
            if (selectedGenres != null) {
                String genreSql = "INSERT INTO genres_games (gameId, genreId) VALUES (?, (SELECT genreId FROM genres WHERE name = ?))";
                try (PreparedStatement stmt = conn.prepareStatement(genreSql)) {
                    for (String genre : selectedGenres) {
                        stmt.setInt(1, gameId);
                        stmt.setString(2, genre);
                        stmt.addBatch();
                    }
                    stmt.executeBatch();
                }
            }

            // Link to platforms
            if (selectedPlatforms != null) {
                String platformSql = "INSERT INTO platforms_games (gameId, platformId) VALUES (?, (SELECT platformId FROM platforms WHERE name = ?))";
                try (PreparedStatement stmt = conn.prepareStatement(platformSql)) {
                    for (String platform : selectedPlatforms) {
                        stmt.setInt(1, gameId);
                        stmt.setString(2, platform);
                        stmt.addBatch();
                    }
                    stmt.executeBatch();
                }
            }

            conn.commit(); // Transaction successful

        } catch (SQLException e) {
            e.printStackTrace();
            throw new IOException("Database error: " + e.getMessage());
        }
    }

    private String getFileExtension(Part part) {
        String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        int lastDot = submittedFileName.lastIndexOf('.');
        return (lastDot > 0) ? submittedFileName.substring(lastDot) : "";
    }

    public List<String> getAllGenres() throws SQLException, ClassNotFoundException {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT name FROM genres";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                genres.add(rs.getString("name"));
            }
        }
        return genres;
    }

    public List<String> getAllPlatforms() throws SQLException, ClassNotFoundException {
        List<String> platforms = new ArrayList<>();
        String sql = "SELECT name FROM platforms";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                platforms.add(rs.getString("name"));
            }
        }
        return platforms;
    }
}

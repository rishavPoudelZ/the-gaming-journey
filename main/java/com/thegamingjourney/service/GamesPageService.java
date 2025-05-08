package com.thegamingjourney.service;

import com.thegamingjourney.model.Game;
import com.thegamingjourney.model.Genre;
import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.dao.GenreDao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GamesPageService {

    // Method to get all games sorted by rating
    public List<Game> getAllGamesSortedByRating() throws SQLException, ClassNotFoundException {
        List<Game> games = new ArrayList<>();
        String query = "SELECT g.gameId, g.title, g.description, g.developer, g.releaseDate, g.dateUploaded, " +
                       "g.imagesUrl, g.avgRating, g.GameUrl, g.age_restriction " +
                       "FROM games g " +
                       "ORDER BY g.avgRating DESC";
        
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
        }
        return games;
    }

    // Method to get games filtered by genre and sorted by rating
    public List<Game> getGamesByGenreSortedByRating(String genre) throws SQLException, ClassNotFoundException {
        List<Game> games = new ArrayList<>();
        String query = "SELECT g.gameId, g.title, g.description, g.developer, g.releaseDate, g.dateUploaded, " +
                       "g.imagesUrl, g.avgRating, g.GameUrl, g.age_restriction " +
                       "FROM games g " +
                       "JOIN genres_games gg ON g.gameId = gg.gameId " +
                       "JOIN genres ge ON gg.genreId = ge.genreId " +
                       "WHERE ge.name = ? " +
                       "ORDER BY g.avgRating DESC";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, genre);  // Set the genre to filter by
            try (ResultSet rs = stmt.executeQuery()) {
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
            }
        }
        return games;
    }
    
    public List<Genre> getAllGenres() throws ClassNotFoundException {
        GenreDao genreDao = new GenreDao();  // Assuming you have a GenreDao class to interact with the database
        return genreDao.getAllGenres();  // Fetches all genres from the 'genres' table
    }
}

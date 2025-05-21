package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.Game;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminGameListService {

    public List<Game> getAllGames() throws ClassNotFoundException, SQLException {
        List<Game> games = new ArrayList<>();

        String gameQuery = "SELECT * FROM games";
        String genreQuery = "SELECT g.name FROM genres g JOIN genres_games gg ON g.genreId = gg.genreId WHERE gg.gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement gameStmt = conn.prepareStatement(gameQuery);
             ResultSet gameRs = gameStmt.executeQuery()) {

            while (gameRs.next()) {
                Game game = new Game();
                game.setGameId(gameRs.getInt("gameId"));
                game.setTitle(gameRs.getString("title"));
                game.setDescription(gameRs.getString("description"));
                game.setDeveloper(gameRs.getString("developer"));
                game.setReleaseDate(gameRs.getDate("releaseDate"));
                game.setDateUploaded(gameRs.getDate("dateUploaded"));
                game.setImagesUrl(gameRs.getString("imagesUrl"));
                game.setAvgRating(gameRs.getInt("avgRating"));
                game.setGameUrl(gameRs.getString("GameUrl"));
                game.setAgeRestriction(gameRs.getString("age_restriction"));

                // Fetch genres for each game
                try (PreparedStatement genreStmt = conn.prepareStatement(genreQuery)) {
                    genreStmt.setInt(1, game.getGameId());
                    ResultSet genreRs = genreStmt.executeQuery();

                    List<String> genres = new ArrayList<>();
                    while (genreRs.next()) {
                        genres.add(genreRs.getString("name"));
                    }
                    game.setGenres(genres);
                }

                games.add(game);
            }
        }

        return games;
    }
    
    public Game getGameById(int gameId) throws Exception {
        String gameQuery = "SELECT * FROM games WHERE gameId = ?";
        String genreQuery = "SELECT g.name FROM genres g JOIN genres_games gg ON g.genreId = gg.genreId WHERE gg.gameId = ?";
        String platformQuery = "SELECT p.name FROM platforms p JOIN platforms_games gp ON p.platformId = gp.platformId WHERE gp.gameId = ?";

        Game game = null;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(gameQuery)) {

            stmt.setInt(1, gameId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                game = new Game();
                game.setGameId(rs.getInt("gameId"));
                game.setTitle(rs.getString("title"));
                game.setDescription(rs.getString("description"));
                game.setDeveloper(rs.getString("developer"));
                game.setReleaseDate(rs.getDate("releaseDate"));
                game.setGameUrl(rs.getString("GameUrl"));
                game.setAgeRestriction(rs.getString("age_restriction"));
                game.setAvgRating(rs.getInt("avgRating"));
            }

            // Genres
            PreparedStatement genreStmt = conn.prepareStatement(genreQuery);
            genreStmt.setInt(1, gameId);
            ResultSet genreRs = genreStmt.executeQuery();
            List<String> genres = new ArrayList<>();
            while (genreRs.next()) {
                genres.add(genreRs.getString("name"));
            }
            game.setGenres(genres);

            // Platforms
            PreparedStatement platStmt = conn.prepareStatement(platformQuery);
            platStmt.setInt(1, gameId);
            ResultSet platRs = platStmt.executeQuery();
            List<String> platforms = new ArrayList<>();
            while (platRs.next()) {
                platforms.add(platRs.getString("name"));
            }
            game.setPlatforms(platforms);
        }

        return game;
    }

    public List<String> getAllGenres() throws Exception {
        List<String> genres = new ArrayList<>();
        String query = "SELECT name FROM genres";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                genres.add(rs.getString("name"));
            }
        }
        return genres;
    }

    public List<String> getAllPlatforms() throws Exception {
        List<String> platforms = new ArrayList<>();
        String query = "SELECT name FROM platforms";
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                platforms.add(rs.getString("name"));
            }
        }
        return platforms;
    }
    
    public List<String> getGenresForGame(int gameId) throws SQLException, ClassNotFoundException {
        List<String> genres = new ArrayList<>();
        String query = "SELECT g.name FROM genres g JOIN genres_games gg ON g.genreId = gg.genreId WHERE gg.gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, gameId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                genres.add(rs.getString("name"));
            }
        }
        return genres;
    }
    
    public List<String> getPlatformsForGame(int gameId) throws SQLException, ClassNotFoundException {
        List<String> platforms = new ArrayList<>();
        String query = "SELECT p.name FROM platforms p JOIN platforms_games pg ON p.platformId = pg.platformId WHERE pg.gameId = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, gameId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                platforms.add(rs.getString("name"));
            }
        }
        return platforms;
    }
    
    public void updateGame(Game game, String[] genres, String[] platforms) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DbConfig.getDbConnection();
            conn.setAutoCommit(false);

            // Update game details
            String updateGameSql = "UPDATE games SET title=?, description=?, developer=?, releaseDate=?, age_restriction=?, gameUrl=? WHERE gameId=?";
            stmt = conn.prepareStatement(updateGameSql);
            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getDescription());
            stmt.setString(3, game.getDeveloper());
            stmt.setDate(4, (Date) game.getReleaseDate());
            stmt.setString(5, game.getAgeRestriction());
            stmt.setString(6, game.getGameUrl());
            stmt.setInt(7, game.getGameId());
            stmt.executeUpdate();

            // Delete existing genre/platform mappings
            try (PreparedStatement deleteGenres = conn.prepareStatement("DELETE FROM genres_games WHERE gameId = ?");
                 PreparedStatement deletePlatforms = conn.prepareStatement("DELETE FROM platforms_games WHERE gameId = ?")) {
                deleteGenres.setInt(1, game.getGameId());
                deleteGenres.executeUpdate();
                deletePlatforms.setInt(1, game.getGameId());
                deletePlatforms.executeUpdate();
            }

            // Re-insert genres
            if (genres != null) {
                String insertGenreSql = "INSERT INTO genres_games (genreId, gameId) VALUES ((SELECT genreId FROM genres WHERE name = ?), ?)";
                try (PreparedStatement genreStmt = conn.prepareStatement(insertGenreSql)) {
                    for (String genre : genres) {
                        genreStmt.setString(1, genre);
                        genreStmt.setInt(2, game.getGameId());
                        genreStmt.addBatch();
                    }
                    genreStmt.executeBatch();
                }
            }

            // Re-insert platforms
            if (platforms != null) {
                String insertPlatformSql = "INSERT INTO platforms_games (platformId, gameId) VALUES ((SELECT platformId FROM platforms WHERE name = ?), ?)";
                try (PreparedStatement platformStmt = conn.prepareStatement(insertPlatformSql)) {
                    for (String platform : platforms) {
                        platformStmt.setString(1, platform);
                        platformStmt.setInt(2, game.getGameId());
                        platformStmt.addBatch();
                    }
                    platformStmt.executeBatch();
                }
            }

            conn.commit();
        } catch (Exception e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
    
    public void deleteGameById(int gameId) throws Exception {
        String deleteGenres = "DELETE FROM genres_games WHERE gameId = ?";
        String deletePlatforms = "DELETE FROM platforms_games WHERE gameId = ?";
        String deleteGame = "DELETE FROM games WHERE gameId = ?";

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);

            try (
                PreparedStatement stmt1 = conn.prepareStatement(deleteGenres);
                PreparedStatement stmt2 = conn.prepareStatement(deletePlatforms);
                PreparedStatement stmt3 = conn.prepareStatement(deleteGame)
            ) {
                stmt1.setInt(1, gameId);
                stmt1.executeUpdate();

                stmt2.setInt(1, gameId);
                stmt2.executeUpdate();

                stmt3.setInt(1, gameId);
                stmt3.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }
        }
    }




}
 
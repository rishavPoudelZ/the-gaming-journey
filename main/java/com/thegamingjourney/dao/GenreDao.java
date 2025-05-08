package com.thegamingjourney.dao;

import com.thegamingjourney.model.Genre;
import com.thegamingjourney.config.DbConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GenreDao {

    public List<Genre> getAllGenres() throws ClassNotFoundException {
        List<Genre> genres = new ArrayList<>();
        String query = "SELECT * FROM genres";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Genre genre = new Genre();
                genre.setGenreId(rs.getInt("genreId"));
                genre.setName(rs.getString("name"));
                genres.add(genre);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return genres;
    }
}

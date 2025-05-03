package com.thegamingjourney.service;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.User;
import com.thegamingjourney.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterService {

    // Check if username already exists
    public boolean usernameExists(String username) throws SQLException, ClassNotFoundException {
        String sql = "SELECT 1 FROM users WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // returns true if username exists
        }
    }

    // Register user
    public boolean registerUser(User user) throws SQLException, ClassNotFoundException {
        String encryptedPassword = PasswordUtil.encrypt(user.getUsername(), user.getPassword());
        if (encryptedPassword == null) {
            return false;
        }

        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "INSERT INTO users (username, email, password, role, joindate, profile_picture_filename) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, user.getUsername());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, encryptedPassword);
                stmt.setString(4, user.getRole());
                stmt.setDate(5, java.sql.Date.valueOf(user.getJoinDate()));
                stmt.setString(6, user.getProfilePictureFileName());

                return stmt.executeUpdate() > 0;
            }
        }
    }
}

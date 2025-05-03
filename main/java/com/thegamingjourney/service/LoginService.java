package com.thegamingjourney.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.thegamingjourney.config.DbConfig;
import com.thegamingjourney.model.User;
import com.thegamingjourney.util.PasswordUtil;

public class LoginService {

    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String encryptedPassword = rs.getString("password");
                String decrypted = PasswordUtil.decrypt(encryptedPassword, username);

                if (decrypted != null && decrypted.equals(password)) {
                    return new User(
                    		rs.getInt("userId"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("role"),
                            rs.getDate("joindate").toLocalDate(),
                            rs.getString("profile_picture_filename")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // invalid credentials
    }
    
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("userId"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getDate("joindate").toLocalDate(),
                    rs.getString("profile_picture_filename")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}

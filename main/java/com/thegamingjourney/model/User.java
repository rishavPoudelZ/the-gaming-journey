package com.thegamingjourney.model;

import java.time.LocalDate;

public class User {
    private int userId;
    private String username;
    private String email;
    private String password;
    private String role;
    private LocalDate joinDate;
    private String profilePictureFileName; 

    // Constructors
    public User() {}

    public User(String username, String email, String password, String profilePictureFileName) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.profilePictureFileName = profilePictureFileName;
        this.role = "user";
        this.joinDate = LocalDate.now();
    }

    public User(int userId, String username, String email, String password, String role, LocalDate joinDate, String profilePictureFileName) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.joinDate = joinDate;
        this.profilePictureFileName = profilePictureFileName;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public LocalDate getJoinDate() { return joinDate; }
    public void setJoinDate(LocalDate joinDate) { this.joinDate = joinDate; }

    public String getProfilePictureFileName() { return profilePictureFileName; }
    public void setProfilePictureFileName(String profilePictureFileName) { this.profilePictureFileName = profilePictureFileName; }
}

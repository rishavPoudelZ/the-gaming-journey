package com.thegamingjourney.model;

import java.util.Date;

public class Review {
    private int reviewId;
    private int userId;
    private int gameId;
    private String reviewText;
    private Date reviewDate;
    private int likes;
    private int dislikes;
    private String username;

    // Extra field to show game title when joining with games table
    private String gameTitle;

    // Constructors
    public Review() {}

    public Review(int reviewId, int userId, int gameId, String reviewText, Date reviewDate, int likes, int dislikes, String gameTitle) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.gameId = gameId;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
        this.likes = likes;
        this.dislikes = dislikes;
        this.gameTitle = gameTitle;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGameId() {
        return gameId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }

    public String getGameTitle() {
        return gameTitle;
    }

    public void setGameTitle(String gameTitle) {
        this.gameTitle = gameTitle;
    }
}
